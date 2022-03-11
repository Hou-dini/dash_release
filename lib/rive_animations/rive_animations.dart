import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rive/rive.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/helpers/audio_player.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

/// Indifferent bird minding its own business displayed in the DashatarTheme.
class BoredBirdAnimation extends StatefulWidget {
  /// Indifferent bird minding its own business displayed in the DashatarTheme.
  const BoredBirdAnimation({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<BoredBirdAnimation> createState() => _BoredBirdAnimation();
}

class _BoredBirdAnimation extends State<BoredBirdAnimation> {
  late final AudioPlayer? _audioPlayer;

  // Variable to hold value from the Rive StateMachine.
  SMITrigger? _isPoked;

  @override
  void initState() {
    super.initState();

    // Initialize the audioPlayer for the animation when it is rendered.
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/screeching_bird.mp3');
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer?.dispose();
  }

  Future<void> _onRiveInit(Artboard artboard) async {
    // Get an instance of the StateMachineController.
    final controller =
        StateMachineController.fromArtboard(artboard, 'Bored Bird');

    // Add controller to artboard.
    artboard.addController(controller!);

    // Retrieve input from the StateMachine and store its value.
    _isPoked = controller.findInput<bool>('Pressed') as SMITrigger?;
  }

  // Function to execute SMITrigger value.
  // When triggered, the bird jumps.
  void _jump() {
    if (_isPoked?.value != null) _isPoked!.fire();
  }

  @override
  Widget build(BuildContext context) {
    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            if (_isPoked?.value != null) _jump();
            unawaited(_audioPlayer?.replay());
          },
          child: RiveAnimation.asset(
            'assets/rive/bird.riv',
            artboard: 'Bored Bird',
            onInit: _onRiveInit,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

/// Animation for HourGlass in DashatarTheme.
class HourGlassAnimation extends StatefulWidget {
  /// Animation for HourGlass in DashatarTheme.
  const HourGlassAnimation({Key? key}) : super(key: key);

  @override
  State<HourGlassAnimation> createState() => _HourGlassAnimation();
}

class _HourGlassAnimation extends State<HourGlassAnimation> {
  SMITrigger? _start;

  Future<void> _onRiveInit(Artboard artboard) async {
    final controller =
        StateMachineController.fromArtboard(artboard, 'Hour Glass');

    artboard.addController(controller!);

    _start = controller.findInput<bool>('Start') as SMITrigger?;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onStart() {
    if (_start?.value != null) _start!.fire();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic status =
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);
    final hasStarted = status == DashatarPuzzleStatus.started;

    setState(() {
      if (hasStarted) _onStart();
    });

    return RiveAnimation.asset(
      'assets/rive/hourglass.riv',
      artboard: 'Hour Glass',
      onInit: _onRiveInit,
      fit: BoxFit.cover,
    );
  }
}

/// Cool dude on his skateboard.
class FlyingBoyAnimation extends StatefulWidget {
  /// Cool dude on his skateboard.
  const FlyingBoyAnimation({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<FlyingBoyAnimation> createState() => _FlyingBoyAnimation();
}

class _FlyingBoyAnimation extends State<FlyingBoyAnimation> {
  SMITrigger? _isStumbling;
  SMIBool? _isFlying;

  late final AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();

    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/ow.mp3');
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer?.dispose();
  }

  Future<void> _onRiveInit(Artboard artboard) async {
    final controller =
        StateMachineController.fromArtboard(artboard, 'Flying Board');

    artboard.addController(controller!);

    _isStumbling = controller.findInput<bool>('isStumbling') as SMITrigger?;
    _isFlying = controller.findInput<bool>('isFlying') as SMIBool?;

    setState(() {
      if (_isFlying?.value != null) _isFlying!.value = true;
    });
  }

  void _onStumbling() {
    if (_isStumbling?.value != null) _isStumbling!.fire();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (__, child) => Align(
        alignment: Alignment.centerLeft,
        child: SizedBox.square(
          key: const Key('flying_boy_small'),
          dimension: 50,
          child: child,
        ),
      ),
      medium: (__, child) => Align(
        alignment: Alignment.centerLeft,
        child: SizedBox.square(
          key: const Key('flying_boy_medium'),
          dimension: 70,
          child: child,
        ),
      ),
      large: (__, child) => Align(
        alignment: Alignment.centerLeft,
        child: SizedBox.square(
          key: const Key('flying_boy_large'),
          dimension: 150,
          child: child,
        ),
      ),
      child: (_) => AudioControlListener(
        audioPlayer: _audioPlayer,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              unawaited(_audioPlayer?.replay());
              return _onStumbling();
            },
            child: RiveAnimation.asset(
              'assets/rive/flyingboy.riv',
              artboard: 'Flying Board',
              onInit: _onRiveInit,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

/// Animation rendered on the puzzle background.
class BackgroundAnimation extends StatefulWidget {
  /// Animation rendered on the puzzle background.
  const BackgroundAnimation({Key? key}) : super(key: key);

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimation();
}

class _BackgroundAnimation extends State<BackgroundAnimation> {
  SMITrigger? _on;

  Future<void> _onRiveInit(Artboard artboard) async {
    final controller = StateMachineController.fromArtboard(artboard, 'Fall');

    artboard.addController(controller!);

    _on = controller.findInput<bool>('on') as SMITrigger?;

    setState(() {
      if (_on?.value != null) _onFall();
    });
  }

  void _onFall() {
    if (_on?.value != null) _on!.fire();
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/rive/falling.riv',
      artboard: 'Fall',
      onInit: _onRiveInit,
      fit: BoxFit.cover,
    );
  }
}

/// Flying Dash animation.
class FlyingDash extends StatefulWidget {
  /// Flying Dash animation.
  const FlyingDash({Key? key}) : super(key: key);

  @override
  State<FlyingDash> createState() => _FlyingDash();
}

class _FlyingDash extends State<FlyingDash> {
  SMIBool? _fly;

  Future<void> _onRiveInit(Artboard artboard) async {
    final controller =
        StateMachineController.fromArtboard(artboard, 'Flying Dash');

    artboard.addController(controller!);

    _fly = controller.findInput<bool>('fly') as SMIBool?;

    setState(() {
      if (_fly?.value != null) _fly!.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => SizedBox.square(
        key: const Key('flying_dash_small'),
        dimension: 100,
        child: child,
      ),
      medium: (context, child) => SizedBox.square(
        key: const Key('flying_dash_medium'),
        dimension: 150,
        child: child,
      ),
      large: (context, child) => SizedBox.square(
        key: const Key('flying_dash_large'),
        dimension: 200,
        child: child,
      ),
      child: (__) => RiveAnimation.asset(
        'assets/rive/dash.riv',
        artboard: 'Flying Dash',
        onInit: _onRiveInit,
        fit: BoxFit.cover,
      ),
    );
  }
}

/// Animation for dancing Dash.
class DancingDashAnimation extends StatefulWidget {
  /// Animation for dancing Dash.
  const DancingDashAnimation({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<DancingDashAnimation> createState() => _DancingDashAnimation();
}

class _DancingDashAnimation extends State<DancingDashAnimation> {
  SMIBool? _isDancing;

  late final AudioPlayer? _audioPlayer;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), () {
      _audioPlayer = widget._audioPlayerFactory()
        ..setAsset('assets/audio/hello.mp3');
      _audioPlayer?.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _audioPlayer?.dispose();
  }

  Future<void> _onRiveInit(Artboard artboard) async {
    final controller = StateMachineController.fromArtboard(artboard, 'birb');

    artboard.addController(controller!);

    _isDancing = controller.findInput<bool>('dance') as SMIBool?;

    setState(() {
      if (_isDancing?.value != null) _isDancing!.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => SizedBox(
        key: const Key('dancing_dash_small'),
        width: 184,
        height: 118,
        child: child,
      ),
      medium: (_, child) => SizedBox(
        key: const Key('dancing_dash_medium'),
        width: 380.44,
        height: 214,
        child: child,
      ),
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(bottom: 53),
        child: SizedBox(
          key: const Key('dancing_dash_large'),
          width: 568.99,
          height: 320,
          child: child,
        ),
      ),
      child: (__) => RiveAnimation.asset(
        'assets/rive/birb.riv',
        artboard: 'birb',
        stateMachines: const ['birb'],
        onInit: _onRiveInit,
      ),
    );
  }
}

/// Animation for shuffle icon button.
class ShuffleIconAnimation extends StatelessWidget {
  /// Animation for shuffle icon button.
  const ShuffleIconAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 70,
      child: RiveAnimation.asset(
        'assets/rive/shuffle_icon.riv',
        animations: ['shuffle icon'],
        artboard: 'shuffle icon',
        fit: BoxFit.cover,
      ),
    );
  }
}

/// Animation for ChamaeleonShareDialog.
class CosmosAnimation extends StatelessWidget {
  /// Animation for ChamaeleonShareDialog.
  const CosmosAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(
      'assets/rive/cosmos.riv',
      animations: ['cosmos'],
      artboard: 'cosmos',
      fit: BoxFit.cover,
    );
  }
}
