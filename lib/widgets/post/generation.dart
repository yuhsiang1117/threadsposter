import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Generation extends StatefulWidget {
  const Generation({super.key});

  @override
  State<Generation> createState() => _GenerationState();
}

class _GenerationState extends State<Generation> {
  final TextEditingController _generatedTextController = TextEditingController(
    text: '這裡將顯示 AI 生成的文字內容。點擊生成按鈕開始創建內容。',
  );
  
  final TextEditingController _customTextController = TextEditingController();

  @override
  void dispose() {
    _generatedTextController.dispose();
    _customTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('生成結果'),
          const SizedBox(height: 8),
          _buildTextArea(_generatedTextController),
          const SizedBox(height: 16),
          _buildActionButtons(),
          const SizedBox(height: 16),
          _buildSectionHeader('重新輸入'),
          const SizedBox(height: 8),
          _buildTextArea(_customTextController, 
            hintText: '您可以在這裡編輯或重新輸入想要的內容...'
          ),
          const SizedBox(height: 24),
          _buildBottomButtons(),
        ],
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

  Widget _buildTextArea(TextEditingController controller, {String? hintText}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
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
      ),
    );
  }

  Widget _buildActionButtons() {
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
        _buildActionButton(
          label: '複製',
          onPressed: () {
            Clipboard.setData(ClipboardData(text: _generatedTextController.text));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('文字已複製到剪貼板')),
            );
          },
        ),
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF65558F),
        foregroundColor: Colors.white,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: () {
            // 使用自定義文字處理邏輯
            setState(() {
              _generatedTextController.text = _customTextController.text;
              _customTextController.clear();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF65558F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('使用此文字'),
        ),
      ],
    );
  }
}