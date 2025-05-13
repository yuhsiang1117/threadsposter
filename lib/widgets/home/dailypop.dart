import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:provider/provider.dart';


List<String> taglist = [
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
    required this.screenwidth,
    required this.index,
  });

  final double screenwidth;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          // Handle tap event
          final nav = Provider.of<NavigationService>(context, listen: false);
          nav.goHome(tab: HomeTab.post);
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenwidth * 0.05),
                  child: Text(
                    taglist[index],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: screenwidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenwidth * 0.05),
                  child: Text(
                    "立即發文>",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: screenwidth * 0.03,
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