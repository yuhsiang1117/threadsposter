import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/api.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String customTone = '';
bool isInitialized = false;
bool isUserExist = false;

Future<bool> checkUserDocumentExists(String? uid) async {
  try {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('profile')
        .doc('info');
    final docSnapshot = await docRef.get();
    // 將結果儲存避免重複查詢
    if (!isUserExist && docSnapshot.exists) {
      isUserExist = true;
    }
    return docSnapshot.exists;
  } catch (e) {
    print('Error checking document: $e');
    return false;
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final TextEditingController _customToneController = TextEditingController();
  late final InfiniteScrollController carouselController;
  late Future<bool> _future;
  late String? uid;
  late AnimationController _textController;
  late Animation<int> _textAnimation;
  String _lastDescription = '';
  late int currentPage;

  @override
  void initState() {
    super.initState();
    final toneProvider = Provider.of<ToneProvider>(context, listen: false);
    currentPage = toneProvider.currentPage;
    debugPrint('[lib/widgets/home/home_page.dart] Home Page Building...');
    carouselController = InfiniteScrollController(initialItem: currentPage);
    uid = context.read<UserDataProvider>().uid;
    if (!isUserExist){
      print("uid is $uid\n\n");
      _future = checkUserDocumentExists(uid);
    }
    else {
      _future = Future.value(true);
    }
    // 做你想做的事，例如發出請求或設定變數
    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    if (!isInitialized) {
      Future.microtask((){
        // ignore: use_build_context_synchronously
        Provider.of<ToneProvider>(context, listen: false).fetchTones();
      });
      isInitialized = true;
    }
    updateWeight();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  }

  @override
  void dispose() {
    _textController.dispose();
    _customToneController.dispose();
    super.dispose();
  }

  void _startTextAnimation(String text) {
    _textController.stop();
    _textController.reset();
    _textController.duration = Duration(milliseconds: (100 * text.length).toInt());
    _textAnimation = StepTween(begin: 0, end: text.length).animate(
      CurvedAnimation(parent: _textController, curve: Curves.linear),
    );
    _textController.forward();
  }

  void refresh() {
    setState(() {
      _future = checkUserDocumentExists(uid);
    });
  }
  
  void showWeightChooseDialog(BuildContext context) {
    print("更新權重");
    Map<String, double> newweight;
    final uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    final userinfo = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("profile")
          .doc("info");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('請選擇一個選項'),
        content: const Text('你希望生成的文章哪個面向較為重要？'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('關鍵字相關性');
              // 可在這裡執行紅色選項的邏輯
            },
            child: const Text('關鍵字相關性'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('流量');
              // 可在這裡執行藍色選項的邏輯
            },
            child: const Text('流量'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('時效性');
              // 可在這裡執行綠色選項的邏輯
            },
            child: const Text('時效性'),
          ),
        ],
      ),
    ).then((selected) async {
      if (selected != null) {
        if (selected == '關鍵字相關性') {
          await changeWeight(weight: 'relevance');
          final updatedweight = await getWeight();
          print(updatedweight['relevance']);
          await userinfo.update({'weight': updatedweight});
        } else if (selected == '流量') {
          await changeWeight(weight: 'traffic');
          final updatedweight = await getWeight();
          print(updatedweight['traffic']);
          await userinfo.update({'weight': updatedweight});
        } else if (selected == '時效性') {
          await changeWeight(weight: 'recency');
          final updatedweight = await getWeight();
          print(updatedweight['recency']);
          await userinfo.update({'weight': updatedweight});
        }
        else {
          newweight = {
            'relevance': 0.6,
            'traffic': 0.3,
            'recency': 0.1,
          };
        }
        if (context.mounted) {
          context.read<UserDataProvider>().refreshData();
        }
        // userinfo.update({
        //   'weight': newweight
        // });
      }
    });
  }

  void updateWeight() async {
    
    final uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    if (uid == null) return;

    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('profile')
        .doc('info');
    final docSnapshot = await userDoc.get();
    var notlikepostnums = docSnapshot.data()?['NotLikePostNums'] ?? 0;
    print("article number:${notlikepostnums}");
    if (notlikepostnums >= 5) {
      showWeightChooseDialog(context);
      notlikepostnums = 0; // 超過5篇不喜歡的文章，觸發權重調整
    }

    await userDoc.update({'NotLikePostNums': notlikepostnums});
    if (context.mounted) {
        context.read<UserDataProvider>().refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    uid = context.watch<UserDataProvider>().uid;

    if (uid == null) {
      return const Scaffold(body: Center(child: Text('尚未登入')));
    }

    return FutureBuilder<bool>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text('發生錯誤')));
        }

        final bool isExistingUser = snapshot.data ?? false;
        print("is exist user:${snapshot.data}");
        print(uid);
        if (isExistingUser == false) {
          // 可以導去首次登入設定頁面，也可以顯示引導訊息
          WidgetsBinding.instance.addPostFrameCallback((_) {
              final navigationService = Provider.of<NavigationService>(context, listen: false);
              navigationService.goFirstLogin();
            }
          );
          return const SizedBox();
        }

        // ✅ 如果使用者不是第一次登入，就顯示原本的 Home UI
        return buildMainHomeContent(context);
      },
    );
  }

  Widget buildMainHomeContent(BuildContext context){

    final double screenWidth = MediaQuery.of(context).size.width;
    final toneOptions = Provider.of<ToneProvider>(context).tones;
    _customToneController.text = customTone;
    // 如果沒有載入語氣選項，顯示載入中指示器
    if (toneOptions.isEmpty) {
      debugPrint('[lib/widgets/home/home_page.dart] No tone options available, showing loading indicator');
      return const Center(child: CircularProgressIndicator());
    }

    final description = toneOptions[currentPage].description;
    if (_lastDescription != description) {
      _lastDescription = description;
      _startTextAnimation(description);
    }

    // 角色切換時即時切換主題
    return AnimatedBuilder(
      animation: Listenable.merge([
        _textController,
        context.watch<ToneProvider>()
      ]),
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.white.withOpacity(0.7),
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
                Colors.black26.withOpacity(0.7),
              ],
              stops: [0.0, 0.6, 1.0],
              center: Alignment.topCenter,
              radius: 1.3,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                '選擇角色',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              centerTitle: false,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 2,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () {
                    final navigationService = Provider.of<NavigationService>(context, listen: false);
                    navigationService.goSetting();
                  }
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    width: screenWidth,
                    height: screenWidth,
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    alignment: Alignment.center,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double itemWidth = constraints.maxWidth * 0.6;
                        return ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(
                            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.trackpad},
                          ),
                          child: InfiniteCarousel.builder(
                            itemCount: toneOptions.length,
                            controller: carouselController,
                            velocityFactor: 0.02,
                            itemExtent: itemWidth,
                            loop: true,
                            onIndexChanged: (index) {
                              setState(() {
                                currentPage = index;
                              });
                              // 通知主題切換
                              Provider.of<ToneProvider>(context, listen: false).currentPage = index;
                            },
                            itemBuilder: (context, itemIndex, realIndex) {
                              int diff = (itemIndex - currentPage) % toneOptions.length;
                              if (diff > toneOptions.length / 2) diff -= toneOptions.length;
                              double scale = diff == 0 ? 1.0 : 0.8;
                              double opacity = diff == 0 ? 1.0 : 0.5;
                              return Center(
                                child: Transform.scale(
                                  scale: scale,
                                  child: Opacity(
                                    opacity: opacity,
                                    child: SizedBox(
                                      width: itemWidth,
                                      child: CharacterCard(
                                        screenWidth: screenWidth,
                                        index: itemIndex,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            child: currentPage == toneOptions.length - 1
                              ? Center(
                                  child: SizedBox(
                                    width: screenWidth * 0.6,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '@',
                                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: TextField(
                                            controller: _customToneController,
                                            onChanged: (value) {
                                              setState(() {
                                                customTone = value;
                                              });
                                            },
                                            decoration: const InputDecoration(
                                              hintText: '請輸入UserID',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                              ),
                                              isDense: true,
                                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                            ),
                                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Stack(
                                    children: [ 
                                      Text(
                                        toneOptions[currentPage].name,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 2
                                            ..color = Colors.white,
                                        ),
                                      ),
                                      Text(
                                        toneOptions[currentPage].name,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Stack(
                      children: [ 
                        Text(
                          toneOptions[currentPage].description.substring(0, _textAnimation.value),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.white,
                          ),
                        ),
                        Text(
                          toneOptions[currentPage].description.substring(0, _textAnimation.value),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}