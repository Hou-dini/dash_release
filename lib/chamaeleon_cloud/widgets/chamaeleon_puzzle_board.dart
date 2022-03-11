import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/widgets/chamaeleon_share_dialog.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/bloc/puzzle_bloc.dart';
import 'package:very_good_slide_puzzle/theme/bloc/theme_bloc.dart';

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

/// Displays puzzle board for the chamaeleonTheme in a stack filled
/// with [tiles].
class ChamaeleonPuzzleBoard extends StatefulWidget {
  /// Displays puzzle board for the chamaeleonTheme in a stack
  /// filled with [tiles].
  const ChamaeleonPuzzleBoard({
    Key? key,
    required this.tiles,
  }) : super(key: key);

  /// List of tiles to be displayed.
  final List<Widget> tiles;

  @override
  State<ChamaeleonPuzzleBoard> createState() => _ChamaeleonPuzzleBoardState();
}

class _ChamaeleonPuzzleBoardState extends State<ChamaeleonPuzzleBoard> {
  Timer? _completePuzzleTimer;

  @override
  void dispose() {
    super.dispose();
    _completePuzzleTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PuzzleBloc, PuzzleState>(
      listener: (context, state) async {
        if (state.puzzleStatus == PuzzleStatus.complete) {
          _completePuzzleTimer =
              Timer(const Duration(milliseconds: 370), () async {
            await showAppDialog<void>(
              context: context,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<ThemeBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<PuzzleBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<AudioControlBloc>(),
                  ),
                ],
                child: const ChamaeleonShareDialog(),
              ),
            );
          });
        }
      },
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          key: const Key('chamaeleon_puzzle_board_small'),
          dimension: _BoardSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox.square(
          key: const Key('chamaeleon_puzzle_board_medium'),
          dimension: _BoardSize.medium,
          child: child,
        ),
        large: (_, child) => SizedBox.square(
          key: const Key('chamaeleon_puzzle_board_large'),
          dimension: _BoardSize.large,
          child: child,
        ),
        child: (_) => Stack(children: widget.tiles),
      ),
    );
  }
}
