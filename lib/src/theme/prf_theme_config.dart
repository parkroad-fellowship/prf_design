import 'dart:ui';

import 'package:prf_design/src/theme/colors/prf_color_palette.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';

/// Configuration for customising the PRF brand theme.
///
/// Pass an instance to `PRFTheme.light` / `PRFTheme.dark` to override the
/// default navy-blue/lime-green brand colors with a different palette.
///
/// Use [PRFThemeConfig.prf] for the standard PRF brand, or create a custom
/// config with your own primary, secondary, and neutral colors.
class PRFThemeConfig {
  const PRFThemeConfig({
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryPalette,
    required this.secondaryPalette,
    required this.neutralPalette,
    this.purple = PRFColors.purple,
    this.blue = PRFColors.blue,
    this.orange = PRFColors.orange,
    this.emerald = PRFColors.emerald,
  });

  /// Primary brand color (maps to navy blue in the PRF brand).
  final Color primaryColor;

  /// Secondary brand color (maps to lime green in the PRF brand).
  final Color secondaryColor;

  /// 10-stop primary palette (50 = lightest … 900 = darkest).
  ///
  /// Index 5 should equal [primaryColor].
  final List<Color> primaryPalette;

  /// 10-stop secondary palette (50 = lightest … 900 = darkest).
  ///
  /// Index 5 should equal [secondaryColor].
  final List<Color> secondaryPalette;

  /// 10-stop neutral gray palette (50 = lightest … 900 = darkest).
  final List<Color> neutralPalette;

  /// Accent purple.
  final Color purple;

  /// Accent blue.
  final Color blue;

  /// Accent orange.
  final Color orange;

  /// Accent emerald.
  final Color emerald;

  // ---------------------------------------------------------------------------
  // Convenience getters that mirror the PRFColorPalette API
  // ---------------------------------------------------------------------------

  /// Primary color (alias for [primaryColor]).
  Color get primary => primaryColor;

  /// Primary light variant (shade 100).
  Color get primaryLight => primaryPalette[1];

  /// Primary container (shade 50, for backgrounds).
  Color get primaryContainer => primaryPalette[0];

  /// Primary dark variant (shade 700).
  Color get primaryDark => primaryPalette[7];

  /// Secondary color (alias for [secondaryColor]).
  Color get secondary => secondaryColor;

  /// Secondary light variant (shade 100).
  Color get secondaryLight => secondaryPalette[1];

  /// Secondary container (shade 50, for backgrounds).
  Color get secondaryContainer => secondaryPalette[0];

  /// Secondary dark variant (shade 700).
  Color get secondaryDark => secondaryPalette[7];

  // ---------------------------------------------------------------------------
  // Default PRF configuration
  // ---------------------------------------------------------------------------

  static const PRFThemeConfig prf = PRFThemeConfig(
    primaryColor: PRFColors.navyBlue,
    secondaryColor: PRFColors.limeGreen,
    primaryPalette: [
      PRFColorPalette.navy50,
      PRFColorPalette.navy100,
      PRFColorPalette.navy200,
      PRFColorPalette.navy300,
      PRFColorPalette.navy400,
      PRFColorPalette.navy500,
      PRFColorPalette.navy600,
      PRFColorPalette.navy700,
      PRFColorPalette.navy800,
      PRFColorPalette.navy900,
    ],
    secondaryPalette: [
      PRFColorPalette.lime50,
      PRFColorPalette.lime100,
      PRFColorPalette.lime200,
      PRFColorPalette.lime300,
      PRFColorPalette.lime400,
      PRFColorPalette.lime500,
      PRFColorPalette.lime600,
      PRFColorPalette.lime700,
      PRFColorPalette.lime800,
      PRFColorPalette.lime900,
    ],
    neutralPalette: [
      PRFColors.gray50,
      PRFColors.gray100,
      PRFColors.gray200,
      PRFColors.gray300,
      PRFColors.gray400,
      PRFColors.gray500,
      PRFColors.gray600,
      PRFColors.gray700,
      PRFColors.gray800,
      PRFColors.gray900,
    ],
  );
}
