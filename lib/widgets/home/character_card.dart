import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:threadsposter/widgets/home/home_page.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.screenWidth,
    required this.index,
  });

  final double screenWidth;
  final int index;

  @override
  Widget build(BuildContext context) {
    final toneProvider = Provider.of<ToneProvider>(context, listen: true);
    final toneOptions = toneProvider.tones;
    final currentPage = toneProvider.currentPage;
    
    return GestureDetector(
      onTap: index != currentPage 
      ? null
      : () {
        final navigationService = Provider.of<NavigationService>(context, listen: false);
        if(index == toneOptions.length - 1) {
          toneOptions[index].name = '@$customTone';
        }
        navigationService.goPost(tone: toneOptions[index].name);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 4.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(
              'assets/images/${toneOptions[index].id}.png',
            width: screenWidth,
            height: screenWidth,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}