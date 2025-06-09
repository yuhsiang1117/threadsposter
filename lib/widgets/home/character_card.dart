import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:threadsposter/widgets/home/home_page.dart';

/// A card widget showing a character image that zooms on tap.
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
    final toneProvider = Provider.of<ToneProvider>(context);
    final toneOptions = toneProvider.tones;
    final currentPage = toneProvider.currentPage;

    toneProvider.customToneDisplay = '@$customTone';
    // Determine toneID and asset path
    final isCustom = (index == toneOptions.length - 1);
    final toneID = isCustom ? 'custom' : toneOptions[index].id;
    final imagePath = 'assets/images/$toneID.png';
    final specificUser =
        isCustom ? toneProvider.customToneDisplay : null;

    return GestureDetector(
      onTap:
          index != currentPage
              ? null
              : () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: true,
                    pageBuilder:
                        (_, __, ___) => ZoomTransitionPage(
                          tag: 'character_$toneID',
                          imagePath: imagePath,
                          toneID: toneID,
                          specificUser: specificUser,
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

/// A full-screen transition that zooms the character image, then navigates to post.
class ZoomTransitionPage extends StatefulWidget {
  final String tag;
  final String imagePath;
  final String toneID;
  final String? specificUser;

  const ZoomTransitionPage({
    super.key,
    required this.tag,
    required this.imagePath,
    required this.toneID,
    this.specificUser,
  });

  @override
  State<ZoomTransitionPage> createState() => _ZoomTransitionPageState();
}

class _ZoomTransitionPageState extends State<ZoomTransitionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnim = Tween<double>(
      begin: 0.8,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));

    _controller.forward().whenComplete(() {
      final navigationService = Provider.of<NavigationService>(
        context,
        listen: false,
      );
      debugPrint('[character_card] specific_user: ${widget.specificUser}');
      if (widget.specificUser != null) {
        navigationService.goPost(
          toneID: widget.toneID,
          specific_user: widget.specificUser!,
        );
      } else {
        navigationService.goPost(toneID: widget.toneID);
      }
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment(0, -0.1),
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Hero(
            tag: widget.tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: screenWidth * 0.6,
                height: screenWidth,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4.0,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(widget.imagePath, fit: BoxFit.cover),
              ),
            ),
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