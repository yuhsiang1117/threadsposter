import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 預設值可從使用者資料帶入
    _nameController.text = context.read<UserDataProvider>().userinfo?['name'];
    _emailController.text = context.read<UserDataProvider>().userinfo?['email'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
  final name = _nameController.text.trim();
  final email = _emailController.text.trim();
  final uid = context.read<UserDataProvider>().uid;
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('個人資料已儲存')),
    );
  FirebaseFirestore.instance.collection('users').doc(uid).collection('profile').doc('info').set({
    'name':name,
    'email':email,
  },SetOptions(merge: true));
  if (context.mounted) {
      context.read<UserDataProvider>().refreshData();
  }
  await Future.delayed(Duration(seconds: 1));
  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('編輯個人資料'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '新的暱稱',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '新的信箱',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('儲存'),
            ),
          ],
        ),
      ),
    );
  }
}
