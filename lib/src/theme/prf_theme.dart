import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/_index.dart';
import 'package:prf_design/src/theme/extensions/_index.dart';
import 'package:prf_design/src/theme/text_theme.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFTheme {
  PRFTheme._();

  static ThemeData light({required double scaleFactor}) {
    final textTheme = PRFTextTheme.getLightTheme(scaleFactor: scaleFactor);

    return ThemeData(
      useMaterial3: true,
      primaryColor: PRFColors.navyBlue,
      scaffoldBackgroundColor: PRFColors.gray50,
      textTheme: textTheme,
      extensions: const <ThemeExtension<dynamic>>[
        PRFColorsExtension.light,
        PRFStatusExtension.light,
      ],
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: PRFColors.navyBlue,
        onPrimary: PRFColors.white,
        secondary: PRFColors.limeGreen,
        onSecondary: PRFColorPalette.navy900,
        error: PRFColors.error,
        onError: PRFColors.white,
        surface: PRFColors.white,
        onSurface: PRFColorPalette.navy800,
        onSurfaceVariant: PRFColors.gray600,
        outline: PRFColors.gray300,
        shadow: Color(0x12090B1F),
        surfaceContainerHighest: PRFColors.gray100,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: PRFColors.gray50,
        foregroundColor: PRFColors.navyBlue,
        elevation: PRFElevationTokens.none,
        scrolledUnderElevation: PRFElevationTokens.none,
        centerTitle: false,
        surfaceTintColor: PRFColors.transparent,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: PRFColors.navyBlue,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PRFColors.navyBlue,
          foregroundColor: PRFColors.white,
          disabledBackgroundColor: PRFColors.gray300,
          disabledForegroundColor: PRFColors.gray600,
          minimumSize: const Size(
            double.infinity,
            PRFButtonTokens.handsetHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: PRFSpacingTokens.xl,
            vertical: PRFSpacingTokens.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
          ),
          elevation: PRFButtonTokens.elevationRest,
          textStyle: PRFTextTheme.getButtonTextStyle(scaleFactor: scaleFactor),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PRFColors.navyBlue,
          side: const BorderSide(color: PRFColors.gray300, width: 1.2),
          minimumSize: const Size(
            double.infinity,
            PRFButtonTokens.handsetHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: PRFSpacingTokens.xl,
            vertical: PRFSpacingTokens.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
          ),
          textStyle: PRFTextTheme.getButtonTextStyle(scaleFactor: scaleFactor),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PRFColors.navyBlue,
          textStyle: PRFTextTheme.getButtonTextStyle(scaleFactor: scaleFactor),
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme(
        textTheme: textTheme,
        fillColor: PRFColors.white,
        outlineColor: PRFColors.gray300,
        focusColor: PRFColors.navyBlue,
      ),
      cardTheme: CardThemeData(
        color: PRFColors.white,
        surfaceTintColor: PRFColors.transparent,
        shadowColor: const Color(0x12090B1F),
        elevation: PRFElevationTokens.sm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
          side: const BorderSide(color: PRFColors.gray200),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: PRFColors.gray200,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.white,
        ),
        backgroundColor: PRFColors.navyBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
        ),
      ),
      chipTheme: ChipThemeData(
        labelStyle: textTheme.labelMedium,
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: PRFColors.white,
        ),
        backgroundColor: PRFColors.gray100,
        selectedColor: PRFColors.navyBlue,
        disabledColor: PRFColors.gray300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: PRFColors.white,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
        ),
      ),
      iconTheme: IconThemeData(
        color: PRFColors.navyBlue,
        size: 22 * scaleFactor,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyMedium,
        inputDecorationTheme: _inputDecorationTheme(
          textTheme: textTheme,
          fillColor: PRFColors.white,
          outlineColor: PRFColors.gray300,
          focusColor: PRFColors.navyBlue,
        ),
      ),
    );
  }

  static ThemeData dark({required double scaleFactor}) {
    final textTheme = PRFTextTheme.getDarkTheme(scaleFactor: scaleFactor);

    return ThemeData(
      useMaterial3: true,
      primaryColor: PRFColors.limeGreen,
      scaffoldBackgroundColor: PRFColorPalette.navy900,
      textTheme: textTheme,
      extensions: const <ThemeExtension<dynamic>>[
        PRFColorsExtension.dark,
        PRFStatusExtension.dark,
      ],
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: PRFColors.limeGreen,
        onPrimary: PRFColorPalette.navy900,
        secondary: PRFColorPalette.navy300,
        onSecondary: PRFColors.white,
        error: PRFStatusTokens.errorMainDark,
        onError: PRFColors.white,
        surface: PRFColorPalette.navy800,
        onSurface: PRFColors.white,
        onSurfaceVariant: PRFColors.gray400,
        outline: PRFColors.gray700,
        shadow: Color(0x33000000),
        surfaceContainerHighest: PRFColorPalette.navy700,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: PRFColorPalette.navy900,
        foregroundColor: PRFColors.white,
        elevation: PRFElevationTokens.none,
        scrolledUnderElevation: PRFElevationTokens.none,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: PRFColors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PRFColors.limeGreen,
          foregroundColor: PRFColorPalette.navy900,
          disabledBackgroundColor: PRFColors.gray700,
          disabledForegroundColor: PRFColors.gray500,
          minimumSize: const Size(
            double.infinity,
            PRFButtonTokens.handsetHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: PRFSpacingTokens.xl,
            vertical: PRFSpacingTokens.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
          ),
          elevation: PRFButtonTokens.elevationRest,
          textStyle: PRFTextTheme.getButtonTextStyle(scaleFactor: scaleFactor),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PRFColors.white,
          side: const BorderSide(color: PRFColors.gray700),
          minimumSize: const Size(
            double.infinity,
            PRFButtonTokens.handsetHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: PRFSpacingTokens.xl,
            vertical: PRFSpacingTokens.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
          ),
          textStyle: PRFTextTheme.getButtonTextStyle(scaleFactor: scaleFactor),
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme(
        textTheme: textTheme,
        fillColor: PRFColorPalette.navy800,
        outlineColor: PRFColors.gray700,
        focusColor: PRFColors.limeGreen,
      ),
      cardTheme: CardThemeData(
        color: PRFColorPalette.navy800,
        surfaceTintColor: PRFColors.transparent,
        shadowColor: const Color(0x33000000),
        elevation: PRFElevationTokens.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
          side: const BorderSide(color: PRFColors.gray700),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: PRFColors.gray700,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColorPalette.navy900,
        ),
        backgroundColor: PRFColors.limeGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
        ),
      ),
      iconTheme: IconThemeData(
        color: PRFColors.white,
        size: 22 * scaleFactor,
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    required TextTheme textTheme,
    required Color fillColor,
    required Color outlineColor,
    required Color focusColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: textTheme.bodySmall?.color,
      ),
      labelStyle: textTheme.bodyMedium?.copyWith(
        color: textTheme.bodySmall?.color,
      ),
      floatingLabelStyle: textTheme.labelMedium?.copyWith(color: focusColor),
      errorStyle: textTheme.bodySmall?.copyWith(color: PRFColors.error),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: PRFSpacingTokens.lg,
        vertical: PRFSpacingTokens.md,
      ),
      border: _inputBorder(outlineColor),
      enabledBorder: _inputBorder(outlineColor),
      focusedBorder: _inputBorder(focusColor, width: 1.8),
      errorBorder: _inputBorder(PRFColors.error),
      focusedErrorBorder: _inputBorder(PRFColors.error, width: 1.8),
      disabledBorder: _inputBorder(outlineColor.withValues(alpha: 0.55)),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
