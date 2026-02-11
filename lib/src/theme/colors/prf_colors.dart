import 'dart:ui';

/// Core color constants for the PRF brand identity.
///
/// This class contains all raw color values used throughout the app.
/// For palette variations (tints/shades), see `PRFColorPalette`.
/// For theme-aware colors, use `PRFColorsExtension` via BuildContext.
abstract final class PRFColors {
  // ============================================
  // BRAND COLORS
  // ============================================

  /// Navy Blue - Primary brand color
  /// Represents: Trust, Faith, Loyalty
  static const Color navyBlue = Color(0xFF17154C);

  /// Lime Green - Secondary brand color
  /// Represents: Growth, Development
  static const Color limeGreen = Color(0xFF93D500);

  // ============================================
  // NEUTRAL COLORS (Gray Scale)
  // ============================================

  static const Color gray50 = Color(0xFFF8F9FA);
  static const Color gray100 = Color(0xFFF1F3F5);
  static const Color gray200 = Color(0xFFE9ECEF);
  static const Color gray300 = Color(0xFFDEE2E6);
  static const Color gray400 = Color(0xFFCED4DA);
  static const Color gray500 = Color(0xFFADB5BD);
  static const Color gray600 = Color(0xFF6C757D);
  static const Color gray700 = Color(0xFF495057);
  static const Color gray800 = Color(0xFF343A40);
  static const Color gray900 = Color(0xFF212529);

  // ============================================
  // STATUS COLORS
  // ============================================

  // Success
  static const Color success = Color(0xFF28A745);
  static const Color successLight = Color(0xFFD4EDDA);
  static const Color successDark = Color(0xFF1E7E34);

  // Warning
  static const Color warning = Color(0xFFFFC107);
  static const Color warningLight = Color(0xFFFFF3CD);
  static const Color warningDark = Color(0xFFD39E00);

  // Error
  static const Color error = Color(0xFF78251B);
  static const Color errorLight = Color(0xFFF8D7DA);
  static const Color errorDark = Color(0xFF5C1D15);

  // Info
  static const Color info = Color(0xFF17A2B8);
  static const Color infoLight = Color(0xFFD1ECF1);
  static const Color infoDark = Color(0xFF117A8B);

  // ============================================
  // ACCENT COLORS
  // Complementary colors for UI states and highlights
  // ============================================

  /// Purple - For mission states, events
  static const Color purple = Color(0xFF6B21A8);

  /// Blue - For contact/initiated states
  static const Color blue = Color(0xFF2563EB);

  /// Orange - For scheduled/pending states
  static const Color orange = Color(0xFFEA580C);

  /// Emerald - For active/ongoing indicators
  static const Color emerald = Color(0xFF10B981);

  // ============================================
  // COMMON COLORS
  // ============================================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
}
