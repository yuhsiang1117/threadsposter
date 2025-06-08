import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/models/post_query.dart';
import 'package:threadsposter/models/query_history.dart';
import 'package:threadsposter/services/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threadsposter/services/UserData_provider.dart';

String currentTone = '';
QueryHistory? queryFromHistory;

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _queryController = TextEditingController();
  bool _isGenerating = false;

  String _selectedStyle = 'Emotion';
  String _selectedTone = 'None';
  // String _selectedTag = '';
  int _selectedSize = parseSize("Short");
  int _selectedDays = 15;
  int _selectedLikes = 1000;
  int _selectedCount = 3;
  String _errorMessage = '';

  PostQuery postQuery = PostQuery(
    userQuery: '',
    tag: '',
    style: 'Emotion',
    withInDays: 15,
    size: parseSize("Short"),
    gclikes: 1000,
    returnCount: 3,
    tone: 'none',
    specificUser: '',
  );

  @override
  void initState() {
    super.initState();
    if (queryFromHistory != null) {
      _tagsController.text = queryFromHistory!.tag;
      _queryController.text = queryFromHistory!.title;
      _selectedStyle = queryFromHistory!.style;
      _selectedSize = parseSize(queryFromHistory!.size);
    }
  }

  @override
  void dispose() {
    _tagsController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final toneProvider = Provider.of<ToneProvider>(context);
    final tones = toneProvider.tones.isNotEmpty ? toneProvider.tones : defaultToneOptions;
    final currentPage = toneProvider.currentPage;
    final currentTone = tones.isNotEmpty && currentPage < tones.length ? tones[currentPage].name : 'none';
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    _selectedTone = queryFromHistory != null ? toneProvider.idToName(queryFromHistory!.tone) : currentTone;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final navigationService = Provider.of<NavigationService>(context, listen: false);
            navigationService.goHome();
          },
        ),
        title: Text(
                '發文',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '目前選擇角色：',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _selectedTone,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildTagsInputField(),
              const SizedBox(height: 10),
              StyleSelection(
                onStyleSelected: (style) {
                  setState(() {
                    _selectedStyle = style;
                  });
                },
              ),
              const SizedBox(height: 10),
              SizeSelection(
                onSizeSelected: (size) {
                  setState(() {
                    _selectedSize = parseSize(size);
                  });
                },
              ),
              const SizedBox(height: 10),
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent, // 移除展開後的分隔線
                  splashColor: Colors.transparent,  // 點擊時不出現水波紋
                  highlightColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,      // 清除 padding（選用）
                  childrenPadding: EdgeInsets.zero,  // 清除展開內容 padding（選用）
                  title: const Text(
                    '進階選項',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  children: [
                    SizedBox(height: 10),
                    DaysSlider(
                      onDaysSelected: (days) {
                        setState(() {
                          _selectedDays = days;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    LikesSlider(
                      onLikesSelected: (likes) {
                        setState(() {
                          _selectedLikes = likes;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    CountSlider(
                      onCountSelected: (count) {
                        setState(() {
                          _selectedCount = count;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildQueryInputField(),
              const SizedBox(height: 20),
              _buildGenerateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagsInputField() {
    return TextField(
      controller: _tagsController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: '請輸入文章主題...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildQueryInputField() {
    return TextField(
      controller: _queryController,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: '請輸入文章內容概述...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildGenerateButton() {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _isGenerating 
            ? null 
            : () {
            setState(() {
              _isGenerating = true;
            });
            _buildPostQuery();
            addHistoryDB(
              Provider.of<UserDataProvider>(context, listen: false).uid!,
              QueryHistory(
                title: postQuery.userQuery,
                tone: Provider.of<ToneProvider>(context, listen: false).idToName(postQuery.tone),
                tag: postQuery.tag,
                style: postQuery.style,
                size: postQuery.size == 10 ? 'Short' : postQuery.size == 30 ? 'Medium' : 'Long',
                specific_user: postQuery.tone == 'custom'? '' : postQuery.specificUser,
              ),
            );
            debugPrint('PostQuery: \\${postQuery.toString()}');
            final navigationService = Provider.of<NavigationService>(context, listen: false);
            //測試文章
            // List<GeneratedPost> testPosts = [
            //   GeneratedPost(
            //     content: '這是一篇測試文章內容 1',
            //     score: 5.6,
            //   ),
            //   GeneratedPost(
            //     content: '這是第二篇測試文章內容',
            //     score: 0.85,
            //   ),
            //   GeneratedPost(
            //     content: '第三篇測試文章',
            //     score: -3.75,
            //   ),
            // ];
            //navigationService.goPostResult(testPosts);
            _sendPostQuery(postQuery).then((result) {
              setState(() {
                _isGenerating = false;
              });
              if (result.isEmpty) {
                setState(() {
                  _errorMessage = '生成文章失敗，請稍後再試';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('生成文章失敗，請稍後再試'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              setState(() {
                _errorMessage = '';
              });
              navigationService.goPostResult(result, postQuery.userQuery, postQuery.style);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _isGenerating ? colorScheme.outline : colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: _isGenerating 
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('生成發文內容', style: TextStyle(fontSize: 18)),
        ),
        if (_errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  void _buildPostQuery() {
    postQuery.userQuery = _queryController.text;
    postQuery.tag = _tagsController.text;
    postQuery.style = _selectedStyle;
    postQuery.withInDays = _selectedDays;
    postQuery.size = _selectedSize;
    postQuery.gclikes = _selectedLikes;
    postQuery.returnCount = _selectedCount;
    // 根據 _selectedTone (name) 找到對應的 ToneOption 並設置 tone
    final toneProvider = Provider.of<ToneProvider>(context, listen: false);
    final toneOptions = toneProvider.tones.isNotEmpty ? toneProvider.tones : defaultToneOptions;
    final toneOption = toneOptions.firstWhere(
      (tone) => tone.name == _selectedTone,
      orElse: () => ToneOption('', _selectedTone, ''),
    ).id;
    postQuery.tone = toneOption;
    if(toneOption == 'custom') {
      postQuery.specificUser = _selectedTone.substring(1);
    } else {
      postQuery.specificUser = '';
    }
  }

  void addHistoryDB(String uid, QueryHistory content) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('history')
        .doc(); // 使用自動生成的文檔 Id

    await docRef.set({
      'title': content.title,
      'tone': content.tone,
      'tag': content.tag,
      'style': content.style,
      'size': content.size,
      'savedAt': FieldValue.serverTimestamp(), // 添加時間戳
    });
  }

  Future<List<GeneratedPost>> _sendPostQuery(PostQuery query) async {
    if (query.tone == 'custom') {
      try{
        return await generateSpecificUserPost(
          userquery: query.userQuery,
          tag: query.tag,
          style: query.style,
          withindays: query.withInDays,
          size: query.size,
          gclikes: query.gclikes,
          recommendation: query.returnCount,
          specific_user: query.specificUser,
        );
      } catch (e) {
        print('[generateSpecificUserPost]發生錯誤: $e');
        return [];
      }
    }
    else {
      try{
        await changeTone(tone: query.tone);
        return await generatePost(
          userquery: query.userQuery,
          tag: query.tag,
          style: query.style,
          withindays: query.withInDays,
          size: query.size,
          gclikes: query.gclikes,
          recommendation: query.returnCount,
          specific_user: query.specificUser,
        );
      } catch (e) {
        print('[generatePost]發生錯誤: $e');
        return [];
      }
    }
  }
}