import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/widgets/widgets.dart';

List<String> tagList = [
  "#地震",
  "#颱風",
  "#大雨",
  "#大雪",
  "#大霧",
  "#大風",
  "#大火",
];

class Dailypop extends StatelessWidget {
  const Dailypop({
    super.key,
    required this.screenWidth,
    required this.index,
  });

  final double screenWidth;
  final int index;

  @override
  Widget build(BuildContext context) {
    final padding = screenWidth * 0.05;
    
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          final navigationService = Provider.of<NavigationService>(context, listen: false);
          navigationService.goHome(tab: HomeTab.post);
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Text(
                    tagList[index],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Text(
                    "立即發文 >",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}