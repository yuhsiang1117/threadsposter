import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        alignment: Alignment.center,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.0,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 0,
          ),
          itemCount: taglist.length,
          itemBuilder: (context, index) => Dailypop(screenwidth: screenwidth, index: index),
        )
      ),
    );
  }
}