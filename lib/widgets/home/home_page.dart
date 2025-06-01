import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

int currentPage = 0;
String customTone = '';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _customToneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      // ignore: use_build_context_synchronously
      Provider.of<ToneProvider>(context, listen: false).fetchTones();
    });
  }

  @override
  void dispose() {
    _customToneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final InfiniteScrollController carouselController = InfiniteScrollController(initialItem: currentPage);
    final toneOptions = Provider.of<ToneProvider>(context).tones;
    _customToneController.text = customTone;

    // 如果沒有載入語氣選項，顯示載入中指示器
    if(toneOptions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('選擇角色'),
        centerTitle: false,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
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
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double itemWidth = constraints.maxWidth;
                  return ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(
                      dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.trackpad},  
                    ),
                    child: InfiniteCarousel.builder(
                      itemCount: toneOptions.length,
                      controller: carouselController,
                      onIndexChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, itemIndex, realIndex) {
                        return SizedBox(
                          width: double.infinity, // 讓每個item寬度等於螢幕寬
                          child: Dailypop(
                            screenWidth: screenWidth,
                            index: itemIndex,
                          ),
                        );
                      },
                      itemExtent: itemWidth, // 讓每個item高度等於螢幕高度
                      loop: true,
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
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          ),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ),
                )
              : Text(
                toneOptions[currentPage].name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: Colors.grey[100],
              padding: const EdgeInsets.all(16.0),
              child: Text(
                toneOptions[currentPage].description,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      )
    );
  }
}