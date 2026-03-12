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
  static const Color navy50 = Color(0xFFEDF1FF);
  static const Color navy100 = Color(0xFFD7E0FF);
  static const Color navy200 = Color(0xFFB6C6F6);
  static const Color navy300 = Color(0xFF95ACEA);
  static const Color navy400 = Color(0xFF6D88D4);

  /// Base navy blue - primary brand color
  static const Color navy500 = Color(0xFF1A2253);

  static const Color navy600 = Color(0xFF141B42);
  static const Color navy700 = Color(0xFF111636);
  static const Color navy800 = Color(0xFF0D112A);
  static const Color navy900 = Color(0xFF090B1F);

  // ============================================
  // LIME GREEN PALETTE
  // ============================================

  /// Very light lime - ideal for backgrounds
  static const Color lime50 = Color(0xFFF6FEEB);
  static const Color lime100 = Color(0xFFEAFCD2);
  static const Color lime200 = Color(0xFFD9F8AE);
  static const Color lime300 = Color(0xFFC4F184);
  static const Color lime400 = Color(0xFFAFE964);

  /// Base lime green - secondary brand color
  static const Color lime500 = Color(0xFF9DE35D);

  static const Color lime600 = Color(0xFF86C14D);
  static const Color lime700 = Color(0xFF67973B);
  static const Color lime800 = Color(0xFF4B6D2A);
  static const Color lime900 = Color(0xFF31481B);

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
