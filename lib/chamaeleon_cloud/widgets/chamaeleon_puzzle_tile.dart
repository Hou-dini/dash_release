import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/chamaeleon_cloud/chamaeleon_theme.dart';
import 'package:very_good_slide_puzzle/helpers/audio_player.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/tile.dart';
import 'package:very_good_slide_puzzle/puzzle/bloc/puzzle_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

abstract class _TileSize {
  static double small = 75;
  static double medium = 100;
  static double large = 112;
}

/// Puzzle [tile] for ChamaeleonTheme.
class ChamaeleonPuzzleTile extends StatefulWidget {
  /// Puzzle [tile] for ChamaeleonTheme.
  const ChamaeleonPuzzleTile({
    Key? key,
    required this.tile,
    required this.state,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  /// The title to be displayed.
  final Tile tile;

  /// The state of the puzzle.
  final PuzzleState state;

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<ChamaeleonPuzzleTile> createState() => ChamaeleonPuzzleTileState();
}

/// The state of [ChamaeleonPuzzleTile].
class ChamaeleonPuzzleTileState extends State<ChamaeleonPuzzleTile>
    with SingleTickerProviderStateMixin {
  AudioPlayer? _audioPlayer;

  late final Timer _timer;

  late AnimationController _controller;

  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: PuzzleThemeAnimationDuration.puzzleTileScale,
    );

    _scale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.elasticInOut),
      ),
    );
// Delay the initialization of the audio player for performance reasons,
    // to avoid dropping frames when the theme is changed.
    _timer = Timer(const Duration(seconds: 1), () {
      _audioPlayer = widget._audioPlayerFactory()
        ..setAsset('assets/audio/tile_move.mp3');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();
    const theme = ChamaeleonTheme();
    final status = context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus);
    final puzzleIncomplete = status == PuzzleStatus.incomplete;

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedAlign(
        alignment: FractionalOffset(
          (widget.tile.currentPosition.x - 1) / (size - 1),
          (widget.tile.currentPosition.y - 1) / (size - 1),
        ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.elasticInOut,
        child: ResponsiveLayoutBuilder(
          small: (_, child) => SizedBox.square(
            key: Key('chamaelon_puzzle_tile_small_${widget.tile.value}'),
            dimension: _TileSize.small,
            child: child,
          ),
          medium: (_, child) => SizedBox.square(
            key: Key('chamaelon_puzzle_tile_medium_${widget.tile.value}'),
            dimension: _TileSize.medium,
            child: child,
          ),
          large: (_, child) => SizedBox.square(
            key: Key('chamaelon_puzzle_tile_large_${widget.tile.value}'),
            dimension: _TileSize.large,
            child: child,
          ),
          child: (_) => MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) {
              if (puzzleIncomplete) _controller.forward();
            },
            onExit: (_) {
              if (puzzleIncomplete) _controller.reverse();
            },
            child: ScaleTransition(
              key: Key('chamaelon_puzzle_tile_scale_${widget.tile.value}'),
              scale: _scale,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: puzzleIncomplete
                    ? () {
                        context.read<PuzzleBloc>().add(TileTapped(widget.tile));
                        unawaited(_audioPlayer?.replay());
                      }
                    : null,
                icon: Image.asset(
                  theme.chamaelonAssetForTile(widget.tile),
                  semanticLabel: context.l10n.puzzleTileLabelText(
                    widget.tile.value.toString(),
                    widget.tile.currentPosition.x.toString(),
                    widget.tile.currentPosition.y.toString(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
