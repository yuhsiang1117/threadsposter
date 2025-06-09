import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
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

  void _registerWithEmail() {
    final navigationService = Provider.of<NavigationService>(context, listen: false);
    navigationService.goRegister();
  }

  Future<String?> showPasswordInputDialog(BuildContext context, String email) {
    final TextEditingController passwordController = TextEditingController();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('關聯帳號'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('你已擁有帳號（$email），將自動關聯，請輸入密碼:'),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '密碼',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(passwordController.text),
              child: const Text('確認'),
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

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      final providers = user?.providerData.map((info) => info.providerId).toList() ?? [];
      final hasEmail = providers.contains('password');

      if (!hasEmail) {
        final password = await _showPasswordDialog();
        if (password != null && password.isNotEmpty) {
          try {
            final emailCredential = EmailAuthProvider.credential(
              email: user!.email!,
              password: password,
            );
            await user.linkWithCredential(emailCredential);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('已成功連結 Email/密碼登入')),
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
        final email = e.email!;
        final pendingCredential = e.credential!;
        final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (signInMethods.contains('password')) {
          final password = await showPasswordInputDialog(context, email) ?? '';
          if (password.isEmpty) return;

          try {
            final emailUserCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password,
            );
            await emailUserCredential.user!.linkWithCredential(pendingCredential);
            print("Google 成功連結到原本帳號");
          } on FirebaseAuthException catch (e) {
            if (e.code == 'wrong-password') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('密碼錯誤，請再試一次')),
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
    } finally {
      setState(() => _isSigningIn = false);
    }
  }

  Future<String?> _showPasswordDialog() async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        final passwordController = TextEditingController();
        final confirmPasswordController = TextEditingController();
        final ValueNotifier<bool> showError = ValueNotifier<bool>(false);

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              title: Row(
                children: [
                  Icon(Icons.lock_outline, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  const Text('設定密碼', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '請輸入密碼以開通/連結電子郵件帳號',
                    style: TextStyle(color: Colors.grey[700], fontSize: 15),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: passwordController,
                    autofocus: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '密碼',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<bool>(
                    valueListenable: showError,
                    builder: (context, value, child) {
                      return TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: '確認密碼',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          errorText: value ? '密碼不一致' : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('取消'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    final password = passwordController.text;
                    final confirmPassword = confirmPasswordController.text;
                    if (password != confirmPassword) {
                      setState(() => showError.value = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('密碼不一致，請重新輸入')),
                      );
                    } else if (password.isEmpty) {
                      setState(() => showError.value = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('密碼不能為空')),
                      );
                    } else {
                      Navigator.of(context).pop(password);
                    }
                  },
                  child: const Text('確認'),
                ),
              ],
            );
          },
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
              boxShadow: const [
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
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: '電子郵件',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '密碼',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),
                _isSigningIn
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
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
                                final navigationService = Provider.of<NavigationService>(context, listen: false);
                                navigationService.goHome();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: const Text('登入', style: TextStyle(fontSize: 18)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: _registerWithEmail,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                foregroundColor: theme.colorScheme.primary,
                                side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('註冊新帳號', style: TextStyle(fontSize: 18)),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              const Expanded(child: Divider(thickness: 1.2)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text('或', style: TextStyle(color: Colors.grey[600])),
                              ),
                              const Expanded(child: Divider(thickness: 1.2)),
                            ],
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: Image.asset(
                                'assets/images/google_logo.png',
                                height: 24,
                                width: 24,
                                errorBuilder: (_, __, ___) => const Icon(Icons.login, color: Colors.red),
                              ),
                              label: const Text('使用 Google 登入', style: TextStyle(fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(vertical: 14),
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
