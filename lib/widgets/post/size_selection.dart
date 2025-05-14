import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';

const List<String> size = [
  'Short',
  'Medium',
  'Long'
];

class SizeSelection extends StatefulWidget {
  const SizeSelection({super.key});
  @override
  State<SizeSelection> createState() => _SizeSelectionState();
}

class _SizeSelectionState extends State<SizeSelection> {

  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = size.first;
  }
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    size.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );
  @override
  Widget build(BuildContext contex) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'medium',
        style: TextStyle(fontSize: 16), // 設定與下拉選單字體相同的字型大小
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final width = textPainter.width + 80; // 加上左右 padding

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '選擇文章長度',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        DropdownMenu<String>(
        initialSelection: size.first,
        textStyle: const TextStyle(fontSize: 16),
        width: width,
        onSelected: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries: menuEntries,
        )
      ]
    );
  }
}