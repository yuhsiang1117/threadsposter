import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          _buildTagSelector(),
          const SizedBox(height: 5),
          ToneSelection(),
          const SizedBox(height: 10),
          StyleSelection(),
          const SizedBox(height: 10),
          SizeSelection(),
          const SizedBox(height: 20),
          _buildInputField(),
          const SizedBox(height: 20),
          _buildGenerateButton(),
        ],
      ),
    );
  }

  Widget _buildTagSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '選擇熱門標籤',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                _buildTag('#地震'),
                _buildTag('#颱風'),
                _buildTag('#大雨'),
                _buildTag('#大雪'),
                _buildTag('#大霧'),
                _buildTag('#大風'),
                _buildTag('#大火'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Chip(
        label: Text(tag),
        backgroundColor: Colors.purple.shade100,
        onDeleted: null,
      ),
    );
  }

  Widget _buildInputField() {
    return TextField(
      controller: _textController,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: '請輸入您想要發表的內容...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildGenerateButton() {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder:
              (context) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: const Generation(),
              ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text('生成發文內容', style: TextStyle(fontSize: 18)),
    );
  }
}
