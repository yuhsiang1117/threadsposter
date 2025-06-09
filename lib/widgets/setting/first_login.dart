import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/widgets/setting/loading_animation.dart';

class FirstLoginPage extends StatefulWidget {
  const FirstLoginPage({super.key});
  
  @override
  State<FirstLoginPage> createState() => _FirstLoginPageState();
}

class _FirstLoginPageState extends State<FirstLoginPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 預設值可從使用者資料帶入
    _nameController.text = '使用者暱稱';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile(BuildContext context) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final name = _nameController.text.trim();
    final email = FirebaseAuth.instance.currentUser?.email;
    print("UID: $uid, Name: $name, Email: $email");
    // 顯示 loading dialog
    print("正在儲存資料...");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SavingDialog(),
    );

    try {

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("profile")
          .doc("info")
          .set({
        'name': name,
        'email': email,
        'nextPostID': 0,
        'weight': {
          'relevance': 0.5,
          'traffic': 0.3,
          'recency': 0.2,
        },
        'NotLikePostNums': 5,
      }, SetOptions(merge: true));

      if (context.mounted) {
        context.read<UserDataProvider>().refreshData();
      }
    } catch (e) {
      print('🔥 發生錯誤: $e');
    } finally {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      final navigationService = Provider.of<NavigationService>(context, listen: false);
      navigationService.goHome();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('輸入使用者資料'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '暱稱',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await _saveProfile(context);
                final navigationService = Provider.of<NavigationService>(context, listen: false);
                navigationService.goHome();
              },
              child: const Text('儲存'),
            ),
          ],
        ),
      ),
    );
  }
}
