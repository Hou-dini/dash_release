// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/chamaeleon_puzzle_layout_delegate.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/chamaeleon_theme.dart';


void main() {
  group('SimpleTheme', () {
    test('supports value comparisons', () {
      expect(
        ChamaeleonTheme(),
        equals(ChamaeleonTheme()),
      );
    });

    test('uses SimplePuzzleLayoutDelegate', () {
      expect(
        ChamaeleonTheme().layoutDelegate,
        equals(ChamaeleonPuzzleLayoutDelegate()),
      );
    });
  });
}
