import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigningIn = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmail() async {
    setState(() => _isSigningIn = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('✅ Email 登入成功');
      
    } on FirebaseAuthException catch (e) {
      print('❌ 登入失敗：${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登入失敗：${e.message}')),
      );
    } finally {
      setState(() => _isSigningIn = false);
    }
  }

  Future<void> _registerWithEmail() async {
    setState(() => _isSigningIn = true);
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('✅ 註冊成功，已自動登入');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('註冊成功')),
      );
      // 先詢問使用者是否要關聯 Google 帳號
      final shouldLink = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('關聯 Google 帳號'),
          content: Text('註冊成功，是否要關聯 Google 帳號？'),
          actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('否'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('是'),
        ),
          ],
        ),
      );

      if (shouldLink == true) {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser != null) {
          final googleAuth = await googleUser.authentication;
          final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
          );
          try {
        await userCredential.user?.linkWithCredential(googleCredential);
        print('已成功關聯 Google 帳號');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('已成功關聯 Google 帳號')),
        );
          } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          // Google 已被其他帳號關聯，提示用戶用 Google 登入
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('此 Google 帳號已被其他帳號關聯，請直接用 Google 登入')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Google 關聯失敗：${e.message}')),
          );
        }
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      print('❌ 註冊失敗：${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('註冊失敗：${e.message}')),
      );
    } finally {
      setState(() => _isSigningIn = false);
    }
  }

  Future<void> _signInWithGoogle() async {
  setState(() => _isSigningIn = true);
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      setState(() => _isSigningIn = false);
      return;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Google 登入
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = userCredential.user;
    List<String> providers;
    if (user != null) {
      providers = user.providerData.map((info) => info.providerId).toList();
    } else {
      providers = [];
    }
    final hasEmail = providers.contains('password');
    if (!hasEmail) {
      // 先詢問是否要關聯 Email
      final shouldLink = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('關聯 Email/密碼'),
          content: Text('您要將此 Google 帳號關聯 Email/密碼登入嗎？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('否'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('是'),
            ),
          ],
        ),
      );
      if (shouldLink == true) {
        final password = await _showPasswordDialog();
        // 尚未連結，彈窗請用戶輸入密碼
        if (password != null && password.isNotEmpty) {
          try {
            final emailCredential = EmailAuthProvider.credential(
              email: user!.email!,
              password: password,
            );
            await user.linkWithCredential(emailCredential);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('已成功連結 Email/密碼登入')),
            );
          } on FirebaseAuthException catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('連結失敗：${e.message}')),
            );
          }
        }
      }
    }
    print('✅ Google 登入成功');
  } catch (e) {
    print('❌ Google 登入失敗：$e');
  } finally {
    setState(() => _isSigningIn = false);
  }
}

// 彈窗讓用戶輸入密碼
Future<String?> _showPasswordDialog() async {
  String? password;
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('設定密碼'),
        content: TextField(
          autofocus: true,
          obscureText: true,
          decoration: InputDecoration(labelText: '請輸入密碼'),
          onChanged: (value) => password = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(password),
            child: Text('確定'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '登入/註冊',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: false,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 2,
      ),
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo or illustration
                CircleAvatar(
                  radius: 38,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  child: Icon(Icons.account_circle, size: 60, color: theme.colorScheme.primary),
                ),
                const SizedBox(height: 18),
                Text(
                  '歡迎回來！',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  '請登入或註冊以繼續',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 28),

                // Email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: '電子郵件',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                // 密碼
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '密碼',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),

                // 登入/註冊/Google
                _isSigningIn
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _signInWithEmail();
                                final navigationService = Provider.of<NavigationService>(context, listen: false);
                                navigationService.goHome();
                              },
                              child: Text('登入', style: TextStyle(fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () async {
                                await _registerWithEmail();
                                final navigationService = Provider.of<NavigationService>(context, listen: false);
                                navigationService.goHome();
                              },
                              child: Text('註冊新帳號', style: TextStyle(fontSize: 18)),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                foregroundColor: theme.colorScheme.primary,
                                side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(child: Divider(thickness: 1.2)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text('或', style: TextStyle(color: Colors.grey[600])),
                              ),
                              Expanded(child: Divider(thickness: 1.2)),
                            ],
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: Image.asset(
                                'assets/google_logo.png',
                                height: 24,
                                width: 24,
                                errorBuilder: (_, __, ___) => Icon(Icons.login, color: Colors.red),
                              ),
                              label: Text('使用 Google 登入', style: TextStyle(fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                                elevation: 2,
                              ),
                              onPressed: () async {
                                await _signInWithGoogle();
                                final navigationService = Provider.of<NavigationService>(context, listen: false);
                                navigationService.goHome();
                              },
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
