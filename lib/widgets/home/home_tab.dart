import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      alignment: Alignment.center,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: tagList.length,
        itemBuilder: (context, index) => Dailypop(
          screenWidth: screenWidth, 
          index: index,
        ),
      )
    );
  }
}