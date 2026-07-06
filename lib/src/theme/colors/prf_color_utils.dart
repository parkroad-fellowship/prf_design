import 'dart:ui';

/// Utilities for generating color palettes from base colors.
abstract final class PRFColorUtils {
  static const _white = Color(0xFFFFFFFF);
  static const _black = Color(0xFF000000);

  /// Generates a 10-stop palette (50–900) from a [baseColor].
  ///
  /// Shade 500 is the base color. Shades 50–400 are increasingly lighter
  /// (closer to white), and shades 600–900 are increasingly darker
  /// (closer to black).
  static List<Color> generatePalette(Color baseColor) {
    return [
      Color.lerp(_white, baseColor, 0.05)!, // 50
      Color.lerp(_white, baseColor, 0.15)!, // 100
      Color.lerp(_white, baseColor, 0.35)!, // 200
      Color.lerp(_white, baseColor, 0.55)!, // 300
      Color.lerp(_white, baseColor, 0.75)!, // 400
      baseColor, // 500
      Color.lerp(baseColor, _black, 0.15)!, // 600
      Color.lerp(baseColor, _black, 0.30)!, // 700
      Color.lerp(baseColor, _black, 0.50)!, // 800
      Color.lerp(baseColor, _black, 0.70)!, // 900
    ];
  }

  /// Generates a 10-stop neutral palette (50–900).
  ///
  /// [lightest] maps to shade 50, [mid] maps to shade 500.
  /// Shades 100–400 are interpolated between [lightest] and [mid].
  /// Shades 600–900 are interpolated between [mid] and near-black.
  static List<Color> generateNeutralPalette(Color lightest, Color mid) {
    return [
      lightest, // 50
      Color.lerp(lightest, mid, 0.33)!, // 100
      Color.lerp(lightest, mid, 0.55)!, // 200
      Color.lerp(lightest, mid, 0.75)!, // 300
      Color.lerp(lightest, mid, 0.90)!, // 400
      mid, // 500
      Color.lerp(mid, _black, 0.15)!, // 600
      Color.lerp(mid, _black, 0.35)!, // 700
      Color.lerp(mid, _black, 0.55)!, // 800
      Color.lerp(mid, _black, 0.75)!, // 900
    ];
  }
}
