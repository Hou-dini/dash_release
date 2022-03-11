import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/puzzle/bloc/puzzle_bloc.dart';
import 'package:very_good_slide_puzzle/puzzle/view/puzzle_page.dart';
import 'package:very_good_slide_puzzle/theme/widgets/puzzle_title.dart';

/// {@template simple_puzzle_title}
/// Displays the title of the puzzle based on [status].
///
/// Shows the success state when the puzzle is completed,
/// otherwise defaults to the Puzzle Challenge title.
/// {@endtemplate}
@visibleForTesting
class ChamaeleonPuzzleTitle extends StatelessWidget {
  /// {@macro simple_puzzle_title}
  const ChamaeleonPuzzleTitle({
    Key? key,
    required this.status,
  }) : super(key: key);

  /// The status of the puzzle.
  final PuzzleStatus status;

  @override
  Widget build(BuildContext context) {
    return PuzzleTitle(
      key: puzzleTitleKey,
      title: context.l10n.puzzleChallengeTitle,
    );
  }
}
