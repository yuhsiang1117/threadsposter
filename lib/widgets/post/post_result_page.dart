import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:threadsposter/services/api.dart';

List<GeneratedPost> currentResult = [];

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // 顯示三個生成結果
              for (int i = 0; i < currentResult.length; i++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionHeader('生成文章 ${i + 1}'),
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
                          onPressed: () {
                            setState(() {
                              _isFavorited[i] = !_isFavorited[i];
                            });
                            if (_isFavorited[i]) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('已加入收藏')),
                              );
                            } else {
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
                  child: Container(
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
                ),
                const SizedBox(height: 12),
              ],
              // _buildActionButtons(),
              const SizedBox(height: 16),
              _buildSectionHeader('重新輸入'),
              const SizedBox(height: 8),
              _buildTextArea(
                _customTextController,
                hintText: '您可以在這裡編輯或重新輸入想要的內容...',
                readOnly: false,
              ),
              const SizedBox(height: 24),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.primary),
        borderRadius: BorderRadius.circular(8),
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