import 'dart:ui';

/// Single source of truth for every raw color value in the PRF brand.
///
/// All palettes, status colors and accents are defined here and nowhere else.
/// Theme-aware colors (surfaces, containers, on-colors) are derived from these
/// in `PRFTheme` via the Material 3 `ColorScheme`.
///
/// Prefer `Theme.of(context).colorScheme` for surfaces and
/// `context.prfColors` for brand anchors when writing widgets.
abstract final class PRFColors {
  // ============================================
  // BRAND COLORS
  // ============================================

  /// Navy Blue - Primary brand anchor.
  static const Color navyBlue = Color(0xFF1A2253);

  /// Lime Green - Secondary brand anchor.
  /// Used for filled secondary buttons, accents, and highlights.
  /// Pair with dark navy (#1A2253 / #090B1F) text for AAA contrast (~9.7:1).
  static const Color limeGreen = Color(0xFF9DE35D);

  // ============================================
  // NAVY BLUE PALETTE (10 stops)
  // ============================================

  /// Very light navy - ideal for tinted backgrounds.
  static const Color navy50 = Color(0xFFEDF1FF);
  static const Color navy100 = Color(0xFFD7E0FF);
  static const Color navy200 = Color(0xFFB6C6F6);
  static const Color navy300 = Color(0xFF95ACEA);
  static const Color navy400 = Color(0xFF6D88D4);

  /// Base navy blue - primary brand color.
  static const Color navy500 = Color(0xFF1A2253);

  static const Color navy600 = Color(0xFF141B42);
  static const Color navy700 = Color(0xFF111636);
  static const Color navy800 = Color(0xFF0D112A);
  static const Color navy900 = Color(0xFF090B1F);

  // ============================================
  // LIME GREEN PALETTE (10 stops)
  // ============================================

  /// Very light lime - ideal for tinted backgrounds.
  static const Color lime50 = Color(0xFFF6FEEB);
  static const Color lime100 = Color(0xFFEAFCD2);
  static const Color lime200 = Color(0xFFD9F8AE);
  static const Color lime300 = Color(0xFFC4F184);
  static const Color lime400 = Color(0xFFAFE964);

  /// Base lime green - secondary brand color.
  static const Color lime500 = Color(0xFF9DE35D);

  static const Color lime600 = Color(0xFF86C14D);
  static const Color lime700 = Color(0xFF67973B);
  static const Color lime800 = Color(0xFF4B6D2A);
  static const Color lime900 = Color(0xFF31481B);

  // ============================================
  // NEUTRAL COLORS (Gray Scale)
  // ============================================

  static const Color gray50 = Color(0xFFF7F9FC);
  static const Color gray100 = Color(0xFFF0F3F8);
  static const Color gray200 = Color(0xFFE6EAF2);
  static const Color gray300 = Color(0xFFD6DDE9);
  static const Color gray400 = Color(0xFFB5C0D3);
  static const Color gray500 = Color(0xFF8F9BB3);
  static const Color gray600 = Color(0xFF6B758D);
  static const Color gray700 = Color(0xFF4B5368);
  static const Color gray800 = Color(0xFF2F3547);
  static const Color gray900 = Color(0xFF171C29);

  // ============================================
  // STATUS COLORS
  // ============================================

  // Success
  static const Color success = Color(0xFF0FA678);
  static const Color successLight = Color(0xFFE8FBF4);
  static const Color successDark = Color(0xFF0C7F5B);

  // Warning
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFFF4E4);
  static const Color warningDark = Color(0xFFD97706);

  // Error
  static const Color error = Color(0xFFD14343);
  static const Color errorLight = Color(0xFFFFE9EA);
  static const Color errorDark = Color(0xFFA93434);

  // Info
  static const Color info = Color(0xFF2E7AF8);
  static const Color infoLight = Color(0xFFEAF1FF);
  static const Color infoDark = Color(0xFF245FD1);

  // ============================================
  // ACCENT COLORS
  // Complementary colors for UI states and highlights
  // ============================================

  /// Purple - For mission states, events.
  static const Color purple = Color(0xFF6E4CEB);

  /// Blue - For contact/initiated states.
  static const Color blue = Color(0xFF296DFF);

  /// Orange - For scheduled/pending states.
  static const Color orange = Color(0xFFEB8B2D);

  /// Emerald - For active/ongoing indicators.
  static const Color emerald = Color(0xFF12B886);

  // ============================================
  // COMMON COLORS
  // ============================================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
}
