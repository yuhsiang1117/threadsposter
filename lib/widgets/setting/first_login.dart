import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:threadsposter/services/UserData_provider.dart';


class FirstLoginPage extends StatefulWidget {
  final VoidCallback onRefresh;
  const FirstLoginPage({super.key, required this.onRefresh});
  
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
    print(uid);
    print(name);
    print(email);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    FirebaseFirestore.instance.collection("users").doc(uid).collection("profile").doc("info").set({
      'name': name,
      'email': email,
      'nextPostID': 0,
      'token': fcmToken,
    }, SetOptions(merge: true));
    if (context.mounted) {
      context.read<UserDataProvider>().refreshData();
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
                widget.onRefresh();
              },
              child: const Text('儲存'),
            ),
          ],
        ),
      ),
    );
  }
}
