import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

/// Chamaeleon cloud portrait displayed on the puzzle page.
class ChamaeleonPortrait extends StatelessWidget {
  /// Chamaeleon cloud portrait displayed on the puzzle page.
  const ChamaeleonPortrait({Key? key}) : super(key: key);

  static const _smallPortraitSize = 80.0;
  static const _normalPortraitSize = 120.0;

  @override
  Widget build(BuildContext context) {
    const asset =
        'assets/images/chamaeleon_cloud_assets/chamaeleon_cloud_gallery/'
        'chamaeleon_cloud_portrait.png';
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final isSmallSize = currentSize == ResponsiveLayoutSize.small;
        final portraitSize =
            isSmallSize ? _smallPortraitSize : _normalPortraitSize;

        return Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset(
            asset,
            width: portraitSize,
            height: portraitSize,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
