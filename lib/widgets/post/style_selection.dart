import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';

const List<String> options = [
  'Emotion',
  'Practicle',
  'Identity',
  'Trend',
];

class StyleSelection extends StatefulWidget {
  const StyleSelection({super.key});
  @override
  State<StyleSelection> createState() => _StyleSelectionState();
}

class _StyleSelectionState extends State<StyleSelection> {

  String? dropdownValue;
  double width = 0.0;

  @override
  void initState() {
    super.initState();
    dropdownValue = options.first;
    updateWidth(dropdownValue!);
  }

  void updateWidth(String value) {
    // 使用 TextPainter 計算字串寬度
    final textPainter = TextPainter(
      text: TextSpan(
        text: value,
        style: TextStyle(fontSize: 16), // 設定與下拉選單字體相同的字型大小
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    setState(() {
      width = textPainter.width + 80; // 加上左右 padding
    });
  }
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    options.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );
  @override
  Widget build(BuildContext contex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '選擇風格',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        DropdownMenu<String>(
        initialSelection: options.first,
        textStyle: const TextStyle(fontSize: 16),
        width: width,
        onSelected: (String? value) {
          setState(() {
            dropdownValue = value!;
            updateWidth(dropdownValue!);
          });
        },
        dropdownMenuEntries: menuEntries,
        )
      ]
    );
  }
}