import 'dart:ui';

import 'package:path/path.dart' as p;
import 'package:very_good_slide_puzzle/chamaeleon_cloud/chamaeleon_puzzle_layout_delegate.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/theme/themes/themes.dart';

/// The chamaeleon cloud puzzle theme.
class ChamaeleonTheme extends PuzzleTheme {
  /// The chamaeleon cloud puzzle theme.
  const ChamaeleonTheme() : super();

  @override
  String get name => 'Chamaeleon Cloud I';

  @override
  bool get hasTimer => false;

  @override
  Color get nameColor => PuzzleColors.grey1;

  @override
  Color get titleColor => PuzzleColors.primary1;

  @override
  Color get backgroundColor => PuzzleColors.white;

  @override
  Color get defaultColor => PuzzleColors.primary5;

  @override
  Color get buttonColor => PuzzleColors.primary6;

  @override
  Color get hoverColor => PuzzleColors.primary3;

  @override
  Color get pressedColor => PuzzleColors.primary7;

  @override
  bool get isLogoColored => true;

  @override
  Color get menuActiveColor => PuzzleColors.grey1;

  @override
  Color get menuUnderlineColor => PuzzleColors.primary6;

  @override
  Color get menuInactiveColor => PuzzleColors.grey2;

  @override
  String get audioControlOnAsset => 'assets/images/audio_control/simple_on.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/simple_off.png';

  /// The path to the directory with chamaeleon_cloud assets for all puzzle
  /// tiles.
  String get chamaelonAssetsDirectory =>
      'assets/images/chamaeleon_cloud_assets';

  /// The path to this theme puzzle complete states success asset.
  String get successThemeAsset =>
      'assets/images/chamaeleon_cloud_assets/success/chamaeleon_cloud_success.png';

  /// The path to the chamaeleon asset for the given tile.
  /// The chamaeleon_cloud asset for the i-th tile may be found in the file
  /// i.png.
  String chamaelonAssetForTile(Tile tile) =>
      p.join(chamaelonAssetsDirectory, '${tile.value.toString()}.png');

  @override
  PuzzleLayoutDelegate get layoutDelegate =>
      const ChamaeleonPuzzleLayoutDelegate();

  @override
  List<Object?> get props => [
        name,
        audioControlOnAsset,
        audioControlOffAsset,
        hasTimer,
        nameColor,
        titleColor,
        backgroundColor,
        defaultColor,
        buttonColor,
        hoverColor,
        pressedColor,
        isLogoColored,
        menuActiveColor,
        menuUnderlineColor,
        menuInactiveColor,
        layoutDelegate,
        chamaelonAssetsDirectory,
        successThemeAsset,
      ];
}
