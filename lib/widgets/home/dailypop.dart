import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/models/data_lists.dart';

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
    
    return GestureDetector(
      onTap: () {
        final navigationService = Provider.of<NavigationService>(context, listen: false);
        navigationService.goPost(tone: toneOptions[index].name);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/${toneOptions[index].name}.png',
          width: screenWidth * 0.8,
          height: screenWidth * 0.8,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}