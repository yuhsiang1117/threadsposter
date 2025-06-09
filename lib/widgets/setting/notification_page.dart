import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/main.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/services/api.dart';
import 'package:threadsposter/widgets/widgets.dart';

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
  void showWeightChooseDialog(BuildContext context) {
    const defaultweight = {
      'relevance': 0.1,
      'traffic': 0.4,
      'recency': 0.5,
    };
    Map<String, double> newweight;
    final uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    final userinfo = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("profile")
          .doc("info");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('請選擇一個選項'),
        content: const Text('你認為生成的文章需要加強哪個面向？'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('關鍵字契合度');
              // 可在這裡執行紅色選項的邏輯
            },
            child: const Text('關鍵字契合度'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('流量');
              // 可在這裡執行藍色選項的邏輯
            },
            child: const Text('流量'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('時效性');
              // 可在這裡執行綠色選項的邏輯
            },
            child: const Text('時效性'),
          ),
        ],
      ),
    ).then((selected) async {
      if (selected != null) {
        if (selected == '關鍵字契合度') {
          await setWeight(weight: defaultweight);
        } else if (selected == '流量') {
          await changeWeight(weight: 'traffic');
        } else if (selected == '時效性') {
          await changeWeight(weight: 'recency');
        }
        else {
          newweight = {
            'relevance': 0.5,
            'traffic': 0.3,
            'recency': 0.2,
          };
        }
        // userinfo.update({
        //   'weight': newweight
        // });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "設定開關",
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Center(
        child: Card(
          elevation: 4,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "功能開關",
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                ),
                const SizedBox(height: 16),
                Switch(
                  value: _isOn,
                  activeColor: colorScheme.primary,
                  inactiveThumbColor: colorScheme.outlineVariant,
                  inactiveTrackColor: colorScheme.surfaceContainerHighest,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isOn = newValue;
                      showWeightChooseDialog(context);
                      _showLocalNotification();
                    });
                  },
                ),
                Text(
                  _isOn ? "已開啟" : "已關閉",
                  style: textTheme.bodyMedium?.copyWith(
                    color: _isOn ? colorScheme.primary : colorScheme.outline,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: colorScheme.surface,
    );
  }
}
