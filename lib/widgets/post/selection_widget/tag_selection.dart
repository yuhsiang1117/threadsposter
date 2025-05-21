import 'package:flutter/material.dart';
import 'package:threadsposter/models/data_lists.dart';

String selectedTag = '';

class TagSelection extends StatefulWidget {

  final void Function(String)? onTagSelected;
  const TagSelection({super.key, this.onTagSelected});

  @override
  State<TagSelection> createState() => _TagSelectionState();
}

class _TagSelectionState extends State<TagSelection> {

  String _selectedTag = '';
  void _onTagChanged(String tag) {
    setState(() {
      _selectedTag = tag;
    });

    if (widget.onTagSelected != null) {
      widget.onTagSelected!(tag); // 傳出去
    }
  }

  @override
  Widget build(BuildContext context) {
    if(selectedTag != '') {
      _selectedTag = selectedTag;
      selectedTag = '';
    }
    return _buildToneSelector();
  }

  Widget _buildToneSelector() {
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
              children: tagOptions.map(
                (tag) {
                  return _buildTag(tag);
                }).toList()
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return TextButton(
      onPressed: () => {
        _onTagChanged(tag)
      },
      child: Chip(
        label: Text(tag),
        backgroundColor: _selectedTag == tag ? Colors.purple : Colors.purple.shade100,
        onDeleted: null,
      ),
    );
  }
  
}