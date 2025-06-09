import 'dart:async';                      // Timer
import 'package:flutter/material.dart';  // UI 元件：Dialog, Text, Padding, etc.

class SavingDialog extends StatefulWidget {
  const SavingDialog({Key? key}) : super(key: key);

  @override
  State<SavingDialog> createState() => SavingDialogState();
}

class SavingDialogState extends State<SavingDialog> {
  int _dotCount = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4; // 0~3 個點
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dots = '.' * _dotCount;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text('正在儲存資料$dots',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
