import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

int currentPage = 0;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final InfiniteScrollController carouselController = InfiniteScrollController(initialItem: currentPage);
    
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
          // 2/3 for角色選擇
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              alignment: Alignment.center,
                child: InfiniteCarousel.builder(
                  itemCount: toneOptions.length,
                  controller: carouselController,
                  onIndexChanged: (index) {
                    setState(() {
                    currentPage = index;
                    });
                  },
                  itemBuilder: (context, itemIndex, realIndex) {
                    return Dailypop(
                    screenWidth: screenWidth,
                    index: itemIndex,
                    );
                  },
                  itemExtent: 300,
                  loop: true,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
                toneOptions[currentPage].name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // 1/3 for角色說明
          Expanded(
            flex: 1,
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