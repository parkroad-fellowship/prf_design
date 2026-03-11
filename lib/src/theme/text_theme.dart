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

    return GoogleFonts.latoTextTheme().copyWith(
      displayLarge: GoogleFonts.lato(
        fontSize: 32 * s,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: defaultTextColor,
        height: 1.2,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.lato(
        fontSize: 28 * s,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: defaultTextColor,
        height: 1.2,
        letterSpacing: -0.25,
      ),
      displaySmall: GoogleFonts.lato(
        fontSize: 24 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: defaultTextColor,
        height: 1.3,
      ),
      headlineLarge: GoogleFonts.lato(
        fontSize: 22 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        color: defaultTextColor,
        height: 1.3,
      ),
      headlineMedium: GoogleFonts.lato(
        fontSize: 18 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: defaultTextColor,
        height: 1.3,
      ),
      headlineSmall: GoogleFonts.lato(
        fontSize: 16 * s,
        fontStyle: FontStyle.normal,
        color: defaultTextColor,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      titleLarge: GoogleFonts.lato(
        fontSize: 20 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: defaultTextColor,
        height: 1.3,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 16 * s,
        fontWeight: FontWeight.w500,
        color: defaultTextColor,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.lato(
        fontSize: 14 * s,
        fontWeight: FontWeight.w500,
        color: defaultTextColor,
        height: 1.4,
      ),
      bodyLarge: GoogleFonts.lato(
        fontSize: 16 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: defaultTextColor,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 14 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: defaultTextColor,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 12 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.lato(
        fontSize: 14 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        color: defaultTextColor,
        height: 1.4,
      ),
      labelMedium: GoogleFonts.lato(
        fontSize: 12 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        color: defaultTextColor,
        height: 1.4,
      ),
      labelSmall: GoogleFonts.lato(
        fontSize: 11 * s,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        height: 1.4,
      ),
    );
  }

  static TextStyle getErrorTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.lato(
      fontSize: 12 * s,
      fontWeight: FontWeight.w500,
      color: PRFColors.error,
      height: 1.4,
    );
  }

  static TextStyle getSuccessTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.lato(
      fontSize: 12 * s,
      fontWeight: FontWeight.w500,
      color: PRFColors.success,
      height: 1.4,
    );
  }

  static TextStyle getWarningTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.lato(
      fontSize: 12 * s,
      fontWeight: FontWeight.w500,
      color: PRFColors.warning,
      height: 1.4,
    );
  }

  static TextStyle getInfoTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.lato(
      fontSize: 12 * s,
      fontWeight: FontWeight.w500,
      color: PRFColors.info,
      height: 1.4,
    );
  }

  static TextStyle getButtonTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.lato(
      fontSize: 14 * s,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
  }

  static TextStyle getCaptionTextStyle({required double scaleFactor}) {
    final s = scaleFactor;
    return GoogleFonts.lato(
      fontSize: 10 * s,
      fontWeight: FontWeight.w400,
      color: PRFColors.gray600,
      height: 1.4,
    );
  }
}
