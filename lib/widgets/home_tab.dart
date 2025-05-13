import 'package:flutter/material.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/widgets/widgets.dart';

List<String> taglist = [
  "#地震",
  "#颱風",
  "#大雨",
  "#大雪",
  "#大霧",
  "#大風",
  "#大火",
]; 
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    return Flexible(
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        alignment: Alignment.center,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.0,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: taglist.length,
          itemBuilder: (context, index) => Card(
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
          ),
        )
      ),
    );
  }
}