import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';

/// Builds the PRF typography scale with the bundled Manrope family.
///
/// Fonts ship offline (declared as a Flutter font family in `pubspec.yaml`),
/// so no runtime network fetching occurs.
class PRFTextTheme {
  PRFTextTheme._();

  /// Public helper kept for consumer compatibility.
  static TextTheme getLightTheme({required double scaleFactor}) => build(
    scaleFactor,
    defaultTextColor: PRFColors.gray900,
    secondaryTextColor: PRFColors.gray600,
  );

  /// Public helper kept for consumer compatibility.
  static TextTheme getDarkTheme({required double scaleFactor}) => build(
    scaleFactor,
    defaultTextColor: PRFColors.gray100,
    secondaryTextColor: PRFColors.gray400,
  );

  static TextTheme build(
    double scaleFactor, {
    required Color defaultTextColor,
    required Color secondaryTextColor,
  }) {
    final s = scaleFactor;

    return TextTheme(
      displayLarge: _manrope(
        s,
        38,
        FontWeight.w800,
        defaultTextColor,
        height: 1.1,
        letterSpacing: -0.9,
      ),
      displayMedium: _manrope(
        s,
        32,
        FontWeight.w700,
        defaultTextColor,
        height: 1.15,
        letterSpacing: -0.5,
      ),
      displaySmall: _manrope(
        s,
        28,
        FontWeight.w700,
        defaultTextColor,
        height: 1.2,
        letterSpacing: -0.3,
      ),
      headlineLarge: _manrope(
        s,
        24,
        FontWeight.w700,
        defaultTextColor,
        height: 1.25,
      ),
      headlineMedium: _manrope(
        s,
        20,
        FontWeight.w700,
        defaultTextColor,
        height: 1.3,
      ),
      headlineSmall: _manrope(
        s,
        18,
        FontWeight.w600,
        defaultTextColor,
        height: 1.35,
      ),
      titleLarge: _manrope(
        s,
        18,
        FontWeight.w700,
        defaultTextColor,
        height: 1.35,
      ),
      titleMedium: _manrope(
        s,
        16,
        FontWeight.w600,
        defaultTextColor,
        height: 1.4,
      ),
      titleSmall: _manrope(
        s,
        14,
        FontWeight.w600,
        defaultTextColor,
        height: 1.4,
      ),
      bodyLarge: _manrope(
        s,
        16,
        FontWeight.w500,
        defaultTextColor,
        height: 1.5,
      ),
      bodyMedium: _manrope(
        s,
        15,
        FontWeight.w500,
        defaultTextColor,
        height: 1.5,
      ),
      bodySmall: _manrope(
        s,
        13,
        FontWeight.w500,
        secondaryTextColor,
        height: 1.45,
      ),
      labelLarge: _manrope(
        s,
        14,
        FontWeight.w700,
        defaultTextColor,
        height: 1.35,
      ),
      labelMedium: _manrope(
        s,
        13,
        FontWeight.w700,
        defaultTextColor,
        height: 1.35,
      ),
      labelSmall: _manrope(
        s,
        12,
        FontWeight.w600,
        secondaryTextColor,
        height: 1.3,
      ),
    );
  }

  static TextStyle _manrope(
    double s,
    double size,
    FontWeight weight,
    Color color, {
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Manrope',
      fontSize: size * s,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Text style for buttons, shared across every button variant.
  static TextStyle getButtonTextStyle({required double scaleFactor}) {
    return _manrope(
      scaleFactor,
      15,
      FontWeight.w700,
      PRFColors.gray900,
      height: 1.2,
    ).copyWith(letterSpacing: 0.1);
  }
}
