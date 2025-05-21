import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/models/post_query.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final TextEditingController _textController = TextEditingController();

  String selectedStyle = 'Emotion';
  String selectedTone = 'None';
  String selectedTag = '';
  int selectedSize = parseSize("Short");

  PostQuery postQuery = PostQuery(
    userQuery: '',
    tag: '',
    style: 'Emotion',
    withInDays: 30,
    size: 20,
    gclikes: 5,
    returnCount: 3,
    tone: 'None',
  );

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
          TagSelection(
            onTagSelected: (tag) {
              setState(() {
                selectedTag = tag;
              });
            },
          ),
          const SizedBox(height: 5),
          ToneSelection(
            onToneSelected: (tone) {
              setState(() {
                selectedTone = tone;
              });
            },
          ),
          const SizedBox(height: 10),
          StyleSelection(
            onStyleSelected: (style) {
              setState(() {
                selectedStyle = style;
              });
            },
          ),
          const SizedBox(height: 10),
          SizeSelection(
            onSizeSelected: (size) {
              setState(() {
                selectedSize = parseSize(size);
              });
            },
          ),
          const SizedBox(height: 20),
          _buildInputField(),
          const SizedBox(height: 20),
          _buildGenerateButton(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return TextField(
      controller: _textController,
      maxLines: 5,
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
        _buildPostQuery();
        print('=======================');
        print(postQuery.toJson());
        print('=======================');
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

  void _buildPostQuery() {
    postQuery.userQuery = _textController.text;
    postQuery.tag = selectedTag;
    postQuery.style = selectedStyle;
    postQuery.withInDays = 30; // TODO: Get selected days
    postQuery.size = selectedSize;
    postQuery.gclikes = 5; // TODO: Get selected gclikes
    postQuery.returnCount = 3; // TODO: Get selected return count
    postQuery.tone = selectedTone;
  }
}
