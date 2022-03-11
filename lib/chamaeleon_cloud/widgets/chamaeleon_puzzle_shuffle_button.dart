import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/helpers/audio_player.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/puzzle/bloc/puzzle_bloc.dart';
import 'package:very_good_slide_puzzle/rive_animations/rive_animations.dart';
import 'package:very_good_slide_puzzle/theme/widgets/puzzle_button.dart';

/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
class ChamaeleonPuzzleShuffleButton extends StatefulWidget {
  /// {@macro puzzle_shuffle_button}
  const ChamaeleonPuzzleShuffleButton({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<ChamaeleonPuzzleShuffleButton> createState() =>
      _ChamaeleonPuzzleShuffleButtonState();
}

class _ChamaeleonPuzzleShuffleButtonState
    extends State<ChamaeleonPuzzleShuffleButton> {
  late final AudioPlayer? _audioPlayer;

  @override
  void initState() {
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/sci_fi_click.mp3');
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: PuzzleButton(
        textColor: PuzzleColors.primary0,
        backgroundColor: PuzzleColors.primary1,
        onPressed: () {
          context.read<PuzzleBloc>().add(const PuzzleReset());
          unawaited(_audioPlayer?.replay());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ShuffleIconAnimation(),
            const Gap(5),
            Text(context.l10n.puzzleShuffle),
          ],
        ),
      ),
    );
  }
}
