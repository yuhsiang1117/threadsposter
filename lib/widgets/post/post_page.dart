import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/services/post_query_provider.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/models/post_query.dart';
import 'package:threadsposter/services/api.dart';

String currentTone = '';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _queryController = TextEditingController();

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
    tone: 'None',
    specificUser: '',
  );

  @override
  void dispose() {
    _tagsController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _selectedTone = currentTone;
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
        final navigationService = Provider.of<NavigationService>(context, listen: false);
        navigationService.goHome();
        },
      ),
      title: const Text('發文'),
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      ),
      body: Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  '目前選擇角色：',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  _selectedTone,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
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
                title: const Text('進階選項'),
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
            _buildTagsInputField(),
            const SizedBox(height: 20),
            _buildQueryInputField(),
            const SizedBox(height: 20),
            _buildGenerateButton(context),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            _buildPostQuery();
            debugPrint('PostQuery: ${postQuery.toString()}');
        
            final navigationService = Provider.of<NavigationService>(context, listen: false);
            // 測試文章
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
            // navigationService.goPostResult(testPosts);
            _sendPostQuery(postQuery).then((result) {
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
              navigationService.goPostResult(result);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('生成發文內容', style: TextStyle(fontSize: 18)),
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
    final toneOption = options.firstWhere(
      (tone) => tone.name == _selectedTone,
      orElse: () => ToneOption('', _selectedTone, ''),
    ).id;
    postQuery.tone = toneOption;
    if(toneOption == 'Custom') {
      postQuery.specificUser = _selectedTone;
    } else {
      postQuery.specificUser = '';
    }
  }

  Future<List<GeneratedPost>> _sendPostQuery(PostQuery query) async {
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
      print('發生錯誤: $e');
      return [];
    }
  }
}