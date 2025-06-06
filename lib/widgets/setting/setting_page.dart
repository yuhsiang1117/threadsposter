import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/widgets/setting/history.dart';
import 'package:threadsposter/widgets/setting/notification.dart';
import 'package:threadsposter/widgets/setting/api_test_widget.dart';
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
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileSection(),
            const SizedBox(height: 24),
            _buildMenuSection(context),
          ],
        ),
      );
    }

    Widget _buildProfileSection() {
      return Card(
        elevation: 2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _name!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _email!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _navigateToEditProfile,
                    child: const Text('編輯個人資料'),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back), // 或 Icons.arrow_back
                onPressed: () {
                  final navigationService = Provider.of<NavigationService>(context, listen: false);
                  navigationService.goHome();
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildMenuSection(BuildContext context) {
      return Card(
        elevation: 2,
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.favorite,
              title: '我的收藏',
              onTap: () {},
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.history,
              title: '歷史紀錄',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.notifications,
              title: '通知設定',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationPage()),
                );
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.api,
              title: 'API 測試工具',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ApiTestWidget()),
                );
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.security,
              title: '隱私設定',
              onTap: () {},
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.help,
              title: '幫助與支援',
              onTap: () {},
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.logout,
              title: '登出',
              onTap: () async {
                try {
                  
                } catch (e, stack) {
                  print('登入失敗: $e');
                  print('stack trace: $stack');
                }
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