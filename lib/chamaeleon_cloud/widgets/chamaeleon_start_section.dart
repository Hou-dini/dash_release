import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/widgets/chamaeleon_portrait.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/widgets/chamaeleon_puzzle_shuffle_button.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/widgets/chamaeleon_puzzle_title.dart';
import 'package:very_good_slide_puzzle/layout/responsive_gap.dart';
import 'package:very_good_slide_puzzle/layout/responsive_layout_builder.dart';
import 'package:very_good_slide_puzzle/puzzle/bloc/puzzle_bloc.dart';
import 'package:very_good_slide_puzzle/puzzle/view/puzzle_page.dart';
import 'package:very_good_slide_puzzle/theme/widgets/number_of_moves_and_tiles_left.dart';
import 'package:very_good_slide_puzzle/theme/widgets/puzzle_name.dart';

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
@visibleForTesting
class ChamaeleonStartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const ChamaeleonStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 130,
        ),
        PuzzleName(
          key: puzzleNameKey,
        ),
        const ResponsiveGap(large: 16),
        ChamaeleonPuzzleTitle(
          status: state.puzzleStatus,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: state.numberOfTilesLeft,
        ),
        const ResponsiveGap(
          large: 32,
          small: 16,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => Column(
            children: const [
              ChamaeleonPuzzleShuffleButton(),
              ChamaeleonPortrait(),
            ],
          ),
        ),
      ],
    );
  }
}
