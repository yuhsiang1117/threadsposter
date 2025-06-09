import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/widgets/home/home_page.dart';
import 'package:threadsposter/widgets/setting/scheduled_posts_page.dart';
import 'edit_profile.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
} 
  class _SettingState extends State<Setting> {
    
    String? _name;
    String? _email;

    void _navigateToEditProfile() async {
      await Navigator.push(context,MaterialPageRoute(builder: (context) => const EditProfilePage()));
      setState(() {});
    }
  

    @override
    Widget build(BuildContext context) {
      _name = context.watch<UserDataProvider>().userinfo?['name'];
      _email = context.watch<UserDataProvider>().userinfo?['email'];
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final navigationService = Provider.of<NavigationService>(context, listen: false);
              navigationService.goHome();
            },
          ),
          title: Text('設定', style: theme.textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary)),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
        children: [
          _buildProfileSection(),
          const SizedBox(height: 24),
          _buildMenuSection(context),
        ],
          ),
        ),
      );
    }

    Widget _buildProfileSection() {
      final navigationService = Provider.of<NavigationService>(context, listen: false);
      return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/profile_placeholder.png'),
          ),
          const SizedBox(height: 16),
          Text(
          _name ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
          _email ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Center(
          child: ElevatedButton(
            onPressed: () {
              navigationService.goEditProflie();
            },
            child: const Text('編輯個人資料'),
          ),
          ),
        ],
        ),
      ),
      );
    }

    Widget _buildMenuSection(BuildContext context) {
      final navigationService = Provider.of<NavigationService>(context, listen: false);
      return Card(
        elevation: 2,
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.favorite,
              title: '我的收藏',
              onTap: () {
                navigationService.goSavedPosts();
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.history,
              title: '歷史紀錄',
              onTap: () {
                navigationService.goHistory();
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.notifications,
              title: '通知設定',
              onTap: () {
                navigationService.goNotification();
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.schedule,
              title: '已排程發文',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ScheduledPostsPage()),
                );
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.api,
              title: 'API 測試工具',
              onTap: () {
                navigationService.goApiTest();
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.app_settings_alt,
              title: 'API 設定',
              onTap: () {
                navigationService.goApisetting();
              },
            ),
            // _buildDivider(),
            // _buildMenuItem(
            //   icon: Icons.help,
            //   title: '幫助與支援',
            //   onTap: () {},
            // ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.logout,
              title: '登出',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('確認登出'),
                    content: Text('確定要登出嗎？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(), // 取消，關閉視窗
                        child: Text('取消'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop(); // 關閉視窗
                          isUserExist = false; // 更新登出狀態
                          final navigationService = Provider.of<NavigationService>(context, listen: false);
                          navigationService.goHome();
                          // 可選：登出後跳轉頁面
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
                        },
                        child: Text('確定'),
                      ),
                    ],
                ),
    );
              },
              textColor: Colors.red,
            ),
          ],
        ),
      );
    }

    Widget _buildMenuItem({
      required IconData icon,
      required String title,
      required VoidCallback onTap,
      Color? textColor,
    }) {
      return ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      );
    }

    Widget _buildDivider() {
      return const Divider(height: 1, indent: 16, endIndent: 16);
    }
  }