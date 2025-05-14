import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/post/generation.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class Selection extends StatefulWidget {
  final List<String> option;
  const Selection({required this.option, super.key});
  @override
  State<Selection> createState() => _Selection();
}

class _Selection extends State<Selection> {
  String? selected;
  @override
  void initState() {
    super.initState();
    selected = widget.option.isNotEmpty ? widget.option.first : null;
  }

  @override
  Widget build(BuildContext contex) {
    return DropdownButton<String>(
      value: selected,
      // icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        setState(() {
          selected = value;
        });
      },
      isExpanded: true,
      // menuWidth: 120,
      items:
          widget.option.map((option) {
            return DropdownMenuItem<String>(value: option, child: Text(option));
          }).toList(),
    );
  }
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
          const SizedBox(height: 10),
          _buildTagSelector(),
          const SizedBox(height: 10),
          Container(
            width: 120,
            child: Selection(
              option: ['Emotion', 'Practicle', 'Identity', 'Trend'],
            ),
          ),
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
