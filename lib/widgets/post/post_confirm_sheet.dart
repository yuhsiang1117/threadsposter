import 'package:flutter/material.dart';

/// 回傳 (isSchedule, scheduleTime)，isSchedule=true=排程發文, false=立即發文, null=取消
Future<(bool?, DateTime?)?> showPostConfirmSheet({
  required BuildContext context,
  required String content,
}) async {
  bool schedule = false;
  DateTime? pickedTime;
  return await showModalBottomSheet<(bool?, DateTime?)>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            left: 20, right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '文章內容確認',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  content,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                value: !schedule,
                onChanged: (v) {
                  setState(() { schedule = false; });
                },
                title: const Text('立即發文'),
              ),
              CheckboxListTile(
                value: schedule,
                onChanged: (v) async {
                  setState(() { schedule = true; });
                  //時間選擇器
                  final now = DateTime.now();
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(now),
                  );
                  if (time != null) {
                    pickedTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                    //若選擇時間已過，則視為明天
                    if (pickedTime!.isBefore(now)) {
                      pickedTime = pickedTime!.add(const Duration(days: 1));
                    }
                  }
                  setState(() {});
                },
                title: const Text('排程發文'),
              ),
              if (schedule)
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: pickedTime == null
                    ? const Text(
                        '請選擇時間', 
                        style: TextStyle(color: Colors.red)
                      )
                    : Text(
                        '預定發文時間：${pickedTime!.hour.toString().padLeft(2, '0')}:${pickedTime!.minute.toString().padLeft(2, '0')} (${pickedTime!.month}/${pickedTime!.day})'
                      ),
                ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, null),
                    child: const Text('取消'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (schedule && pickedTime == null) return;
                      Navigator.pop(context, (schedule, pickedTime));
                    },
                    child: const Text('確定'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
