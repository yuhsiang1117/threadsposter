import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:provider/provider.dart';

enum HomeTab {
  home,
  post,
  setting
}

class HomePage extends StatelessWidget {
  final HomeTab selectedTab;

  const HomePage({super.key, required this.selectedTab});

  void _tapBottomNavigationBarItem(BuildContext context, index) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    nav.goHome(tab: index == 0 ? HomeTab.home : index == 1 ? HomeTab.post : HomeTab.setting);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabs = [
      {
        'page': const Home(),
        'title': '本日熱門',
      },
      {
        'page': const Post(),
        'title': '發文',
      },
      {
        'page': const Setting(),
        'title': '設定',
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tabs[selectedTab.index]['title'],
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: tabs[selectedTab.index]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _tapBottomNavigationBarItem(context, index),
        currentIndex: selectedTab.index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}