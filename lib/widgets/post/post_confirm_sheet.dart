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
                  // 時間選擇器
                  final now = DateTime.now();
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: DateTime(now.year + 1, 12, 31),
                  );
                  if (pickedDate == null) return;
                  final pickedTimeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(now),
                  );
                  if (pickedTimeOfDay == null) return;
                  final scheduled = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTimeOfDay.hour,
                    pickedTimeOfDay.minute,
                  );
                  // 不允許選過去的時間
                  if (scheduled.isBefore(now)) {
                    setState(() {
                      pickedTime = null;
                    });
                    return;
                  }
                  setState(() {
                    pickedTime = scheduled;
                  });
                },
                title: const Text('排程發文'),
              ),
              if (schedule)
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: pickedTime == null
                    ? TextButton(
                        onPressed: () async {
                          final now = DateTime.now();
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: pickedTime ?? now,
                            firstDate: now,
                            lastDate: DateTime(now.year + 1, 12, 31),
                          );
                          if (pickedDate == null) return;
                          final pickedTimeOfDay = await showTimePicker(
                            context: context,
                            initialTime: pickedTime != null
                              ? TimeOfDay(hour: pickedTime!.hour, minute: pickedTime!.minute)
                              : TimeOfDay.fromDateTime(now),
                          );
                          if (pickedTimeOfDay == null) return;
                          final scheduled = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTimeOfDay.hour,
                            pickedTimeOfDay.minute,
                          );
                          if (scheduled.isBefore(now)) {
                            setState(() { pickedTime = null; });
                            return;
                          }
                          setState(() { pickedTime = scheduled; });
                        },
                        child: const Text(
                          '請選擇未來的時間',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    : TextButton(
                        onPressed: () async {
                          final now = DateTime.now();
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: pickedTime ?? now,
                            firstDate: now,
                            lastDate: DateTime(now.year + 1, 12, 31),
                          );
                          if (pickedDate == null) return;
                          final pickedTimeOfDay = await showTimePicker(
                            context: context,
                            initialTime: pickedTime != null
                              ? TimeOfDay(hour: pickedTime!.hour, minute: pickedTime!.minute)
                              : TimeOfDay.fromDateTime(now),
                          );
                          if (pickedTimeOfDay == null) return;
                          final scheduled = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTimeOfDay.hour,
                            pickedTimeOfDay.minute,
                          );
                          if (scheduled.isBefore(now)) {
                            setState(() { pickedTime = null; });
                            return;
                          }
                          setState(() { pickedTime = scheduled; });
                        },
                        child: Text(
                          '預定發文時間：'
                          '${pickedTime != null ? '${pickedTime!.year}/${pickedTime!.month}/${pickedTime!.day} ' : ''}'
                          '${pickedTime != null ? pickedTime!.hour.toString().padLeft(2, '0') : ''}'
                          '${pickedTime != null ? ':' + pickedTime!.minute.toString().padLeft(2, '0') : ''}',
                          style: const TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline),
                        ),
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
