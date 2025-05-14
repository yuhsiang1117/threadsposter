import 'package:flutter/material.dart';

String _selectedTone = 'None';

class ToneSelection extends StatefulWidget {
  const ToneSelection({super.key});

  @override
  State<ToneSelection> createState() => _ToneSelectionState();
}

class _ToneSelectionState extends State<ToneSelection> {
  @override
  Widget build(BuildContext context) {
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
              '選擇語氣風格',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                _buildTone('None'),
                _buildTone('Boss'),
                _buildTone('Simp'),
                _buildTone('Elder'),
                _buildTone('Elder Simp'),
                _buildTone('Elder Boss'),
                _buildTone('Elder Boss Simp'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTone(String tag) {
    return TextButton(
      onPressed: () => {
        print('Selected tone: $tag'),
        setState(() {
          _selectedTone = tag;
        })
      },
      child: Chip(
        label: Text(tag),
        backgroundColor: _selectedTone == tag ? Colors.purple : Colors.purple.shade100,
        onDeleted: null,
      ),
    );
  }
}