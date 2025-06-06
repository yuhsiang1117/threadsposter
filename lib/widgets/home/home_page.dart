import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

String customTone = '';
int currentPage = 0;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _customToneController = TextEditingController();
  late final InfiniteScrollController carouselController;

  @override
  void initState() {
    debugPrint('[lib/widgets/home/home_page.dart] Home Page Initializing...');
    super.initState();
    carouselController = InfiniteScrollController(initialItem: currentPage);
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
    final toneOptions = Provider.of<ToneProvider>(context).tones;
    _customToneController.text = customTone;

    // 如果沒有載入語氣選項，顯示載入中指示器
    if (toneOptions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // 角色切換時即時切換主題
    return AnimatedBuilder(
      animation: Listenable.merge([Listenable.merge([context.watch<ToneProvider>()])]),
      builder: (context, _) {
        return Scaffold(
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
                                    child: Dailypop(
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
                          : Center(
                              child: Text(
                                toneOptions[currentPage].name,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  color: Theme.of(context).colorScheme.surface,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    toneOptions[currentPage].description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}