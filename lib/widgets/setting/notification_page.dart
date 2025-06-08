import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:threadsposter/main.dart';

Future<void> _showLocalNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'default_channel_id', // 通知通道 ID
    'Default Channel',     // 通道名稱（Android 會顯示）
    channelDescription: 'This is the default notification channel',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(
        android: androidDetails,
        windows: WindowsNotificationDetails(),
      );

  await flutterLocalNotificationsPlugin.show(
    0, // 通知 ID（用來更新或取消用）
    '標題：提醒一下！',
    '內文：你有一個新的消息',
    notificationDetails,
  );
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("設定開關"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "功能開關",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Switch(
                  value: _isOn,
                  activeColor: Colors.deepPurple,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isOn = newValue;
                      _showLocalNotification();
                    });
                  },
                ),
                Text(
                  _isOn ? "已開啟" : "已關閉",
                  style: TextStyle(
                    fontSize: 16,
                    color: _isOn ? Colors.green : Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}
