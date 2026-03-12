import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prf_design/src/theme/colors/_index.dart';

class PRFTextTheme {
  PRFTextTheme._();

  static TextTheme getLightTheme({required double scaleFactor}) => _buildTheme(
    scaleFactor,
    defaultTextColor: PRFColors.black,
    secondaryTextColor: PRFColors.gray600,
  );

  static TextTheme getDarkTheme({required double scaleFactor}) => _buildTheme(
    scaleFactor,
    defaultTextColor: PRFColors.white,
    secondaryTextColor: PRFColors.gray400,
  );

  static TextTheme _buildTheme(
    double scaleFactor, {
    required Color defaultTextColor,
    required Color secondaryTextColor,
  }) {
    final s = scaleFactor;

    return GoogleFonts.manropeTextTheme().copyWith(
      displayLarge: GoogleFonts.manrope(
        fontSize: 38 * s,
        fontWeight: FontWeight.w800,
        color: defaultTextColor,
        height: 1.1,
        letterSpacing: -0.9,
      ),
      displayMedium: GoogleFonts.manrope(
        fontSize: 32 * s,
        fontWeight: FontWeight.w700,
        color: defaultTextColor,
        height: 1.15,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.manrope(
        fontSize: 28 * s,
        fontWeight: FontWeight.w700,
        color: defaultTextColor,
        height: 1.2,
        letterSpacing: -0.3,
      ),
      headlineLarge: GoogleFonts.manrope(
        fontSize: 24 * s,
        fontWeight: FontWeight.w700,
        color: defaultTextColor,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 20 * s,
        fontWeight: FontWeight.w700,
        color: defaultTextColor,
        height: 1.3,
      ),
      headlineSmall: GoogleFonts.manrope(
        fontSize: 18 * s,
        fontWeight: FontWeight.w600,
        color: defaultTextColor,
        height: 1.35,
      ),
      titleLarge: GoogleFonts.manrope(
        fontSize: 17 * s,
        fontWeight: FontWeight.w700,
        color: defaultTextColor,
        height: 1.35,
      ),
      titleMedium: GoogleFonts.manrope(
        fontSize: 15 * s,
        fontWeight: FontWeight.w600,
        color: defaultTextColor,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.manrope(
        fontSize: 14 * s,
        fontWeight: FontWeight.w600,
        color: defaultTextColor,
        height: 1.4,
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 16 * s,
        fontWeight: FontWeight.w500,
        color: defaultTextColor,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 15 * s,
        fontWeight: FontWeight.w500,
        color: defaultTextColor,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.manrope(
        fontSize: 13 * s,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        height: 1.45,
      ),
      labelLarge: GoogleFonts.manrope(
        fontSize: 14 * s,
        fontWeight: FontWeight.w700,
        color: defaultTextColor,
        height: 1.35,
      ),
      labelMedium: GoogleFonts.manrope(
        fontSize: 13 * s,
        fontWeight: FontWeight.w700,
        color: defaultTextColor,
        height: 1.35,
      ),
      labelSmall: GoogleFonts.manrope(
        fontSize: 12 * s,
        fontWeight: FontWeight.w600,
        color: secondaryTextColor,
        height: 1.3,
      ),
    );
  }

  static TextStyle getErrorTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.manrope(
      fontSize: 12 * s,
      fontWeight: FontWeight.w600,
      color: PRFColors.error,
      height: 1.4,
    );
  }

  static TextStyle getSuccessTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.manrope(
      fontSize: 12 * s,
      fontWeight: FontWeight.w600,
      color: PRFColors.success,
      height: 1.4,
    );
  }

  static TextStyle getWarningTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.manrope(
      fontSize: 12 * s,
      fontWeight: FontWeight.w600,
      color: PRFColors.warning,
      height: 1.4,
    );
  }

  static TextStyle getInfoTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.manrope(
      fontSize: 12 * s,
      fontWeight: FontWeight.w600,
      color: PRFColors.info,
      height: 1.4,
    );
  }

  static TextStyle getButtonTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.manrope(
      fontSize: 15 * s,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: 0.1,
    );
  }

  static TextStyle getCaptionTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.manrope(
      fontSize: 11 * s,
      fontWeight: FontWeight.w500,
      color: PRFColors.gray600,
      height: 1.4,
    );
  }
}
