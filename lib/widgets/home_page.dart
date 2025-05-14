import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/widgets/widgets.dart';

enum HomeTab {
  home,
  post,
  setting
}

class HomePage extends StatelessWidget {
  final HomeTab selectedTab;

  const HomePage({super.key, required this.selectedTab});

  void _onNavigationItemTapped(BuildContext context, int index) {
    final navigationService = Provider.of<NavigationService>(context, listen: false);
    final selectedTab = index == 0 
        ? HomeTab.home 
        : index == 1 
            ? HomeTab.post 
            : HomeTab.setting;
    
    navigationService.goHome(tab: selectedTab);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabsConfig = [
      {
        'page': const Home(),
        'title': '本日熱門',
        'icon': const Icon(Icons.home),
        'label': 'Home',
      },
      {
        'page': const Post(),
        'title': '發文',
        'icon': const Icon(Icons.send),
        'label': 'Post',
      },
      {
        'page': const Setting(),
        'title': '設定',
        'icon': const Icon(Icons.settings),
        'label': 'Setting',
      }
    ];

    final currentTabConfig = tabsConfig[selectedTab.index];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentTabConfig['title'],
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: currentTabConfig['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _onNavigationItemTapped(context, index),
        currentIndex: selectedTab.index,
        items: tabsConfig.map((tabConfig) => BottomNavigationBarItem(
          icon: tabConfig['icon'],
          label: tabConfig['label'],
        )).toList(),
      ),
    );
  }
}