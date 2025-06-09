import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/models/data_lists.dart';

/// A card widget showing a character image that zooms and fades on tap.
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
    final navigationService = Provider.of<NavigationService>(
      context,
      listen: false,
    );

    // Determine toneID and image asset path
    final isCustom = index == toneOptions.length - 1;
    final toneID = isCustom ? 'custom' : toneOptions[index].id;
    final imagePath = 'assets/images/$toneID.png';

    return GestureDetector(
      onTap:
          index != currentPage
              ? null
              : () {
                // Handle custom tone display
                if (isCustom) {
                  toneProvider.customToneDisplay = '@\$customTone';
                  debugPrint(
                    '[CharacterCard] Custom tone selected: \${toneProvider.customToneDisplay}',
                  );
                }

                // Navigate to post page immediately
                if (isCustom) {
                  navigationService.goPost(
                    toneID: toneID,
                    specific_user: toneProvider.customToneDisplay,
                  );
                } else {
                  navigationService.goPost(toneID: toneID);
                }

                // Then show zoom+fade animation overlay
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.transparent,
                    pageBuilder:
                        (_, __, ___) => ZoomFadeTransitionPage(
                          tag: 'character_$toneID',
                          imagePath: imagePath,
                        ),
                  ),
                );
              },
      child: Hero(
        tag: 'character_$toneID',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: screenWidth,
            height: screenWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 4.0,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

/// A full-screen transition that zooms and fades the character image.
class ZoomFadeTransitionPage extends StatefulWidget {
  final String tag;
  final String imagePath;

  const ZoomFadeTransitionPage({
    super.key,
    required this.tag,
    required this.imagePath,
  });

  @override
  State<ZoomFadeTransitionPage> createState() => _ZoomFadeTransitionPageState();
}

class _ZoomFadeTransitionPageState extends State<ZoomFadeTransitionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 4.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _opacityAnim = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward().whenComplete(() {
      // Remove the overlay after animation
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Opacity(
              opacity: _opacityAnim.value,
              child: Transform.scale(
                scale: _scaleAnim.value,
                child: Hero(
                  tag: widget.tag,
                  child: Image.asset(widget.imagePath),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}