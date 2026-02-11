import 'dart:ui';

/// Brand color palette variations with tints and shades.
///
/// Provides a complete range of colors from light (50) to dark (900)
/// for both Navy Blue and Lime Green brand colors.
abstract final class PRFColorPalette {
  // ============================================
  // NAVY BLUE PALETTE
  // ============================================

  /// Very light navy - ideal for backgrounds
  static const Color navy50 = Color(0xFFEEEEF5);
  static const Color navy100 = Color(0xFFD5D4E5);
  static const Color navy200 = Color(0xFFABA9CB);
  static const Color navy300 = Color(0xFF817FB1);
  static const Color navy400 = Color(0xFF575497);

  /// Base navy blue - primary brand color
  static const Color navy500 = Color(0xFF17154C);

  static const Color navy600 = Color(0xFF14123F);
  static const Color navy700 = Color(0xFF100F33);
  static const Color navy800 = Color(0xFF0C0B26);
  static const Color navy900 = Color(0xFF08081A);

  // ============================================
  // LIME GREEN PALETTE
  // ============================================

  /// Very light lime - ideal for backgrounds
  static const Color lime50 = Color(0xFFF5FCE6);
  static const Color lime100 = Color(0xFFE6F7BF);
  static const Color lime200 = Color(0xFFCDEF80);
  static const Color lime300 = Color(0xFFB4E740);
  static const Color lime400 = Color(0xFFA4DE20);

  /// Base lime green - secondary brand color
  static const Color lime500 = Color(0xFF93D500);

  static const Color lime600 = Color(0xFF7AB300);
  static const Color lime700 = Color(0xFF628F00);
  static const Color lime800 = Color(0xFF496C00);
  static const Color lime900 = Color(0xFF314800);

  // ============================================
  // CONVENIENCE GETTERS
  // ============================================

  /// Primary color (Navy Blue base)
  static const Color primary = navy500;

  /// Primary light variant
  static const Color primaryLight = navy100;

  /// Primary container (very light, for backgrounds)
  static const Color primaryContainer = navy50;

  /// Primary dark variant
  static const Color primaryDark = navy700;

  /// Secondary color (Lime Green base)
  static const Color secondary = lime500;

  /// Secondary light variant
  static const Color secondaryLight = lime100;

  /// Secondary container (very light, for backgrounds)
  static const Color secondaryContainer = lime50;

  /// Secondary dark variant
  static const Color secondaryDark = lime700;
}
