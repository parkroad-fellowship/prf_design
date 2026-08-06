import 'dart:ui';

import 'package:prf_design/src/theme/colors/prf_colors.dart';

/// Backwards-compatible facade over [PRFColors].
///
/// Kept for consumers that previously imported `PRFColorPalette`. All values
/// live in [PRFColors] (the single source of truth); this class only forwards
/// to them and is removed in a future major version.
abstract final class PRFColorPalette {
  // ============================================
  // NAVY BLUE PALETTE
  // ============================================

  static const Color navy50 = PRFColors.navy50;
  static const Color navy100 = PRFColors.navy100;
  static const Color navy200 = PRFColors.navy200;
  static const Color navy300 = PRFColors.navy300;
  static const Color navy400 = PRFColors.navy400;
  static const Color navy500 = PRFColors.navy500;
  static const Color navy600 = PRFColors.navy600;
  static const Color navy700 = PRFColors.navy700;
  static const Color navy800 = PRFColors.navy800;
  static const Color navy900 = PRFColors.navy900;

  // ============================================
  // LIME GREEN PALETTE
  // ============================================

  static const Color lime50 = PRFColors.lime50;
  static const Color lime100 = PRFColors.lime100;
  static const Color lime200 = PRFColors.lime200;
  static const Color lime300 = PRFColors.lime300;
  static const Color lime400 = PRFColors.lime400;
  static const Color lime500 = PRFColors.lime500;
  static const Color lime600 = PRFColors.lime600;
  static const Color lime700 = PRFColors.lime700;
  static const Color lime800 = PRFColors.lime800;
  static const Color lime900 = PRFColors.lime900;

  // ============================================
  // CONVENIENCE GETTERS
  // ============================================

  /// Primary color (Navy Blue base).
  static const Color primary = PRFColors.navyBlue;

  /// Primary light variant.
  static const Color primaryLight = PRFColors.navy100;

  /// Primary container (very light, for backgrounds).
  static const Color primaryContainer = PRFColors.navy50;

  /// Primary dark variant.
  static const Color primaryDark = PRFColors.navy700;

  /// Secondary color (Lime Green base).
  static const Color secondary = PRFColors.limeGreen;

  /// Secondary light variant.
  static const Color secondaryLight = PRFColors.lime100;

  /// Secondary container (very light, for backgrounds).
  static const Color secondaryContainer = PRFColors.lime50;

  /// Secondary dark variant.
  static const Color secondaryDark = PRFColors.lime700;
}
