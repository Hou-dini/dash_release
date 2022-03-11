// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/chamaeleon_theme.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ThemeState', () {
    test('supports value comparisons', () {
      final themes = [MockPuzzleTheme(), MockPuzzleTheme()];

      expect(
        ThemeState(
          themes: themes,
          theme: themes[0],
        ),
        equals(
          ThemeState(
            themes: themes,
            theme: themes[0],
          ),
        ),
      );
    });

    test('default theme is SimpleTheme', () {
      expect(
        ThemeState(themes: const [ChamaeleonTheme()]).theme,
        equals(ChamaeleonTheme()),
      );
    });

    group('copyWith', () {
      test('updates themes', () {
        final themesA = [ChamaeleonTheme(), GreenDashatarTheme()];
        final themesB = [ChamaeleonTheme(), YellowDashatarTheme()];

        expect(
          ThemeState(
            themes: themesA,
            theme: ChamaeleonTheme(),
          ).copyWith(themes: themesB),
          equals(
            ThemeState(
              themes: themesB,
              theme: ChamaeleonTheme(),
            ),
          ),
        );
      });

      test('updates theme', () {
        final themes = [ChamaeleonTheme(), YellowDashatarTheme()];
        final themeA = ChamaeleonTheme();
        final themeB = YellowDashatarTheme();

        expect(
          ThemeState(
            themes: themes,
            theme: themeA,
          ).copyWith(theme: themeB),
          equals(
            ThemeState(
              themes: themes,
              theme: themeB,
            ),
          ),
        );
      });
    });
  });
}
