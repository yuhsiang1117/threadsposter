
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/api.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/models/save_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threadsposter/widgets/post/post_confirm_sheet.dart';

List<GeneratedPost> currentResult = [];
String currentTitle = '';
String currentStyle = '';

class PostResult extends StatefulWidget {
  const PostResult({super.key});

  @override
  State<PostResult> createState() => _PostResultState();
}

class _PostResultState extends State<PostResult> {
  final TextEditingController _generatedTextController = TextEditingController(
    text: '這裡將顯示 AI 生成的文字內容。點擊生成按鈕開始創建內容。',
  );
  final TextEditingController _customTextController = TextEditingController();
  // 新增一個收藏狀態列表
  List<bool> _isFavorited = [];
  int _editingIndex = -1;
  List<TextEditingController> _editControllers = [];

  @override
  void dispose() {
    _generatedTextController.dispose();
    _customTextController.dispose();
    for (var controller in _editControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addFavoriteDB(String uid, SavedPost content) async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('profile')
        .doc('info');
    final docSnapshot = await userDoc.get();
    int nextPostID = docSnapshot.data()?['nextPostID'] ?? 0;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(); // 使用自動生成的文檔 ID
    
    await userDoc.update({'nextPostID': nextPostID + 1});
    await docRef.set({
      'ID' : nextPostID,
      'title': content.title,
      'content': content.content,
      'style': content.style,
      'savedAt': FieldValue.serverTimestamp(), // 添加時間戳
    });
    final userinfo = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("profile")
          .doc("info");
    final notlikepostnums = context.watch<UserDataProvider>().userinfo?['NotLikePostNums'] ?? 0;
    userinfo.update({'NotLikePostNums': notlikepostnums - 1}); // 重置不喜歡的文章數量
    if (context.mounted) {
        context.read<UserDataProvider>().refreshData();
    }
  }

  void removeFavoriteDB(String uid, SavedPost content) async {

    final query = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .where('title', isEqualTo: content.title)
        .where('content', isEqualTo: content.content)
        .where('style', isEqualTo: content.style)
        .get();

    for (var doc in query.docs) {
      await doc.reference.delete();
    }
    
  }

  void showWeightChooseDialog(BuildContext context) {
    Map<String, double> newweight;
    final uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    final userinfo = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("profile")
          .doc("info");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('請選擇一個選項'),
        content: const Text('你認為生成的文章需要加強哪個面向？'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('關鍵字契合度');
              // 可在這裡執行紅色選項的邏輯
            },
            child: const Text('關鍵字契合度'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('流量');
              // 可在這裡執行藍色選項的邏輯
            },
            child: const Text('流量'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('時效性');
              // 可在這裡執行綠色選項的邏輯
            },
            child: const Text('時效性'),
          ),
        ],
      ),
    ).then((selected) async {
      if (selected != null) {
        if (selected == '關鍵字契合度') {
          newweight = await changeWeight(weight: 'relevance');
        } else if (selected == '流量') {
          newweight = await changeWeight(weight: 'traffic');
        } else if (selected == '時效性') {
          newweight = await changeWeight(weight: 'recency');
        }
        else {
          newweight = {
            'relevance': 0.5,
            'traffic': 0.3,
            'recency': 0.2,
          };
        }
        userinfo.update({
          'weight': newweight
        });
      }
    });
  }

  void updateWeight() async {
    final uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    if (uid == null) return;

    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('profile')
        .doc('info');
    final docSnapshot = await userDoc.get();
    final notlikepostnums = docSnapshot.data()?['NotLikePostNums'] ?? 0;
    int likecount = 0;
    for (var like in _isFavorited) {
      if (like == true) {
        likecount++;
      }
    }
    int newnotlikepostnums = notlikepostnums + currentResult.length - likecount;
    if (newnotlikepostnums > 5) {
      showWeightChooseDialog(context);
      newnotlikepostnums = newnotlikepostnums - 5; // 超過5篇不喜歡的文章，觸發權重調整
    }

    await userDoc.update({'NotLikePostNums': newnotlikepostnums});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    final userinfo = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("profile")
          .doc("info");
    final notlikepostnums = context.watch<UserDataProvider>().userinfo?['NotLikePostNums'] ?? 0;
    userinfo.update({'NotLikePostNums': notlikepostnums + currentResult.length}); // 重置不喜歡的文章數量
    if (context.mounted) {
        context.read<UserDataProvider>().refreshData();
    }
    // 確保收藏狀態長度與結果同步
    if (_isFavorited.length != currentResult.length) {
      _isFavorited = List.generate(currentResult.length, (i) => false);
    }
    if (_editControllers.length != currentResult.length) {
      _editControllers = List.generate(currentResult.length, (i) => TextEditingController(text: currentResult[i].content));
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            updateWeight();
            currentResult.clear();
          },
        ),
        title: Text('生成結果', style: theme.textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary)),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // 主內容
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  for (int i = 0; i < currentResult.length; i++) ...[
                    // 如果正在編輯，非編輯區塊要變灰且不可互動
                    _editingIndex != -1 && _editingIndex != i
                      ? Opacity(
                          opacity: 0.4,
                          child: IgnorePointer(
                            child: _buildResultBlock(i),
                          ),
                        )
                      : _buildResultBlock(i),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 將每個生成文章區塊抽出，方便覆用
  Widget _buildResultBlock(int i) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader('生成文章${i + 1}'),
            Row(
              children: [
                IconButton(
                  icon: Icon(_editingIndex == i ? Icons.check : Icons.edit),
                  color: _editingIndex == i ? Colors.green : colorScheme.primary,
                  tooltip: _editingIndex == i ? '儲存' : '編輯',
                  onPressed: () {
                    setState(() {
                      if (_editingIndex == i) {
                        // 儲存
                        if (_editControllers[i].text.trim().isNotEmpty) {
                          currentResult[i].content = _editControllers[i].text;
                        }
                        _editingIndex = -1;
                      } else {
                        _editingIndex = i;
                      }
                    });
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.copy),
                  color: colorScheme.primary,
                  tooltip: '複製',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: currentResult[i].content));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('文字已複製到剪貼板')),
                    );
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(_isFavorited[i] ? Icons.favorite : Icons.favorite_border),
                  color: _isFavorited[i] ? Colors.red : colorScheme.primary,
                  tooltip: '收藏',
                  onPressed: () async {
                    setState(() {
                      _isFavorited[i] = !_isFavorited[i];
                    });
                            final uid = Provider.of<UserDataProvider>(context, listen: false).uid;
                    if (_isFavorited[i]) {
                              // 將當前結果加入收藏
                              addFavoriteDB(
                                uid!,
                                SavedPost(
                                  title: currentTitle,
                                  content: currentResult[i].content,
                                  style: currentStyle,
                                )
                              );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('已加入收藏')),
                      );
                    } else {
                              // 從收藏中移除
                              removeFavoriteDB(
                                uid!,
                                SavedPost(
                                  title: currentTitle,
                                  content: currentResult[i].content,
                                  style: currentStyle,
                                )
                              );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('已取消收藏')),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        _editingIndex == i
          ? _buildEditableTextArea(i)
          : _buildTextArea(
              TextEditingController(text: currentResult[i].content),
              readOnly: true,
            ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: (currentResult.length > i)
                      ? (currentResult[i].score >= 0.67
                        ? Colors.green
                        : (currentResult[i].score >= 0.33
                          ? Colors.orange
                          : Colors.red))
                      : Colors.purple,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '分數：${(currentResult.length > i) ? currentResult[i].score.toStringAsFixed(2) : '--'}',
                  style: TextStyle(
                    fontSize: 12,
                    color: (currentResult.length > i)
                      ? (currentResult[i].score >= 0.67
                        ? Colors.green
                        : (currentResult[i].score >= 0.33
                          ? Colors.orange
                          : Colors.red))
                      : Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                icon: Icon(Icons.send, color: colorScheme.onPrimary),
                label: const Text('發文'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _editingIndex == i ? null : () async {
                  // 使用獨立檔案的確認 sheet
                  final result = await showPostConfirmSheet(
                    context: context,
                    content: currentResult[i].content,
                  );
                  if (result == null) return;
                  final isSchedule = result.$1;
                  final scheduleTime = result.$2;
                  try {
                    final success = await postWithSchedule(
                      text: currentResult[i].content,
                      time: isSchedule == true ? scheduleTime : null,
                    );
                    if (success && isSchedule == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('發文成功')),
                      );
                    } 
                    else if (success && isSchedule == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('已排程發文')),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('發文失敗')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('發文失敗: $e')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextArea(TextEditingController controller, {String? hintText, bool readOnly = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(12),
          border: InputBorder.none,
        ),
        readOnly: readOnly,
        style: TextStyle(color: colorScheme.onSurface),
      ),
    );
  }

  Widget _buildEditableTextArea(int i) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.08), // 編輯時有主題色淡底
        border: Border.all(
          color: colorScheme.primary,
          width: 2.5, // 邊框加粗
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.25),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _editControllers[i],
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: '請編輯內容',
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
        ),
        style: TextStyle(color: colorScheme.onSurface),
      ),
    );
  }

  Widget _buildActionButtons() {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          label: '重生成',
          onPressed: () {
            // 實現 AI 重生成邏輯
          },
        ),
        const SizedBox(width: 12),
        
        const SizedBox(width: 12),
        _buildActionButton(
          label: '發文',
          onPressed: () {
            Navigator.pop(context);
            // TODO: 實現發文邏輯
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(80, 36),
      ),
      child: Text(label),
    );
  }

  Widget _buildBottomButtons() {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            foregroundColor: colorScheme.primary,
            side: BorderSide(color: colorScheme.primary),
          ),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _generatedTextController.text = _customTextController.text;
              _customTextController.clear();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('使用此文字'),
        ),
      ],
    );
  }
}