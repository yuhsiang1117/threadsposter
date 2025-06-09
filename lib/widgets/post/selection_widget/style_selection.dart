import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/models/data_lists.dart';

class StyleSelection extends StatefulWidget {
  final String selectedStyle;
  final void Function(String)? onStyleSelected;
  const StyleSelection({super.key, this.onStyleSelected, required this.selectedStyle});

  @override
  State<StyleSelection> createState() => _StyleSelectionState();
}

class _StyleSelectionState extends State<StyleSelection> {

  String? selectedStyle;
  double width = 0.0;

  void _onStyleChanged(String tone) {
    if (widget.onStyleSelected != null) {
      widget.onStyleSelected!(tone); // 傳出去
    }
  }

  @override
  void initState() {
    super.initState();
    selectedStyle = widget.selectedStyle;
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardCount = styleOptions.length;
    final cardWidth = screenWidth * 0.8 / cardCount; //螢幕8成空間
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '選擇風格',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: styleOptions.map((style) {
            final bool isSelected = selectedStyle == style;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedStyle = style;
                  });
                  _onStyleChanged(style);
                  updateWidth(style);
                },
                child: Card(
                  color: isSelected ? colorScheme.primary : colorScheme.surface,
                  elevation: isSelected ? 6 : 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected ? colorScheme.primary : colorScheme.outline,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Center(
                      child: Text(
                        style,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}