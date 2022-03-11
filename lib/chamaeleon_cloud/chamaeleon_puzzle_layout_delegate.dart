import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/widgets/chamaeleon_portrait.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/widgets/chamaeleon_puzzle_board.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/widgets/chamaeleon_puzzle_shuffle_button.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/widgets/chamaeleon_puzzle_tile.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/widgets/chamaeleon_start_section.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/rive_animations/rive_animations.dart';

/// {@template simple_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a ChamaeleonTheme.
/// {@endtemplate}
class ChamaeleonPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro simple_puzzle_layout_delegate}
  const ChamaeleonPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => ChamaeleonStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ChamaeleonPortrait(),
              Gap(20),
              ChamaeleonPuzzleShuffleButton(),
            ],
          ),
          medium: (_, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ChamaeleonPortrait(),
              Gap(30),
              ChamaeleonPuzzleShuffleButton(),
            ],
          ),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return const Positioned(
      right: 0,
      bottom: 0,
      child: DancingDashAnimation(
        key: Key('dancing_dash'),
      ),
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
          large: 96,
        ),
        ChamaeleonPuzzleBoard(tiles: tiles),
        const ResponsiveGap(
          large: 96,
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => ChamaeleonPuzzleTile(
        key: Key('chamaelon_puzzle_tile_${tile.value}_small'),
        tile: tile,
        state: state,
      ),
      medium: (_, __) => ChamaeleonPuzzleTile(
        key: Key('chamaelon_puzzle_tile_${tile.value}_medium'),
        tile: tile,
        state: state,
      ),
      large: (_, __) => ChamaeleonPuzzleTile(
        key: Key('chamaelon_puzzle_tile_${tile.value}_large'),
        tile: tile,
        state: state,
      ),
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}
