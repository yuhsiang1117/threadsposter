import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      debugPrint('login email is ${_emailController.text.trim()}');
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
    print('開始註冊');
    final navigationService = Provider.of<NavigationService>(context, listen: false);
    navigationService.goRegister();
  }

  Future<String?> showPasswordInputDialog(BuildContext context, String email) {
  final TextEditingController passwordController = TextEditingController();

  return showDialog<String>(
    context: context,
    barrierDismissible: false, // 點背景不會關閉 dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('關聯帳號'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('你已擁有帳號（$email），將自動關聯，請輸入密碼:'),
            SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密碼',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null), // 使用者取消
            child: Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(passwordController.text);
            },
            child: Text('確認'),
          ),
        ],
      );
    },
  );
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
    print('✅ Google 登入成功');
  } on FirebaseAuthException catch (e) {
  if (e.code == 'account-exists-with-different-credential') {
    // 🟡 錯誤代表這個 email 已用其他登入方式（例如 email/password）註冊
    String email = e.email!;
    AuthCredential pendingCredential = e.credential!;

    // 查出目前這個 email 支援哪些登入方式
    List<String> signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    if (signInMethods.contains('password')) {
  // 要求使用者輸入密碼
    String password = await showPasswordInputDialog(context, email) ?? '';

    if (password.isEmpty) {
      // 使用者取消或未輸入密碼
      return;
    }

    try {
      // 登入原帳號
      UserCredential emailUserCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 🔗 將 Google 資訊與此帳號關聯
      await emailUserCredential.user!.linkWithCredential(pendingCredential);

      print("Google 成功連結到原本帳號");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        // 顯示錯誤提示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('密碼錯誤，請再試一次')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登入失敗：${e.message}')),
        );
      }
    }
  }
  } else {
    print("登入錯誤: ${e.message}");
  }
}
}

// 彈窗讓用戶輸入密碼
Future<String?> _showPasswordDialog() async {
  String? password;
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('你已經擁有帳號，請設定密碼：'),
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
      backgroundColor: theme.colorScheme.surface,
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
                                if (context.mounted) {
                                  context.read<UserDataProvider>().refreshData();
                                }
                                debugPrint('[login.dart] 登入成功，刷新使用者資料');
                                final navigationService = Provider.of<NavigationService>(context, listen: false);
                                navigationService.goHome();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: Text('登入', style: TextStyle(fontSize: 18)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                _registerWithEmail();
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                foregroundColor: theme.colorScheme.primary,
                                side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('註冊新帳號', style: TextStyle(fontSize: 18)),
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
                                if (context.mounted) {
                                  context.read<UserDataProvider>().refreshData();
                                }
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
