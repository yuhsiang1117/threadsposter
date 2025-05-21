import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/models/data_lists.dart';

class StyleSelection extends StatefulWidget {

  final void Function(String)? onStyleSelected;
  const StyleSelection({super.key, this.onStyleSelected});

  @override
  State<StyleSelection> createState() => _StyleSelectionState();
}

class _StyleSelectionState extends State<StyleSelection> {

  String? selectedStyle;
  double width = 0.0;

  void _onStyleChanged(String tone) {
    setState(() {
      selectedStyle = tone;
    });

    if (widget.onStyleSelected != null) {
      widget.onStyleSelected!(tone); // 傳出去
    }
  }

  @override
  void initState() {
    super.initState();
    selectedStyle = styleOptions.first;
    updateWidth(selectedStyle!);
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
    styleOptions.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
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
        initialSelection: styleOptions.first,
        textStyle: const TextStyle(fontSize: 16),
        width: width,
        onSelected: (String? value) {
          setState(() {
            selectedStyle = value!;
            _onStyleChanged(value);
            updateWidth(selectedStyle!);
          });
        },
        dropdownMenuEntries: menuEntries,
        )
      ]
    );
  }
}