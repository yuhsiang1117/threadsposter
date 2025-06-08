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
  double width = 0.0;

  @override
  void initState() {
    super.initState();
    selectedSize = size.first;
    updateWidth(selectedSize!);
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
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardCount = size.length;
    final cardWidth = screenWidth * 0.8 / cardCount;

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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: size.map((size) {
            final bool isSelected = selectedSize == size;
            return Container(
              width: cardWidth,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSize = size;
                    _onSizeChanged(size);
                  });
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
                        size,
                        style: TextStyle(
                          fontSize: 16,
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