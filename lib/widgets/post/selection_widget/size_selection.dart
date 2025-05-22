import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/models/data_lists.dart';

class SizeSelection extends StatefulWidget {

  final void Function(String)? onSizeSelected;
  const SizeSelection({super.key, this.onSizeSelected});

  @override
  State<SizeSelection> createState() => _SizeSelectionState();
}

class _SizeSelectionState extends State<SizeSelection> {

  String? selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = size.first;
  }
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    size.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );

  void _onSizeChanged(String size) {
    setState(() {
      selectedSize = size;
    });

    if (widget.onSizeSelected != null) {
      widget.onSizeSelected!(size); // 傳出去
    }
  }

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
            selectedSize = value!;
            _onSizeChanged(value);
          });
        },
        dropdownMenuEntries: menuEntries,
        )
      ]
    );
  }
}

int parseSize(String size) {
  switch (size) {
    case 'Short':
      return 10;
    case 'Medium':
      return 30;
    case 'Long':
      return 50;
    default:
      return 30; // Default to Medium if no match
  }
}