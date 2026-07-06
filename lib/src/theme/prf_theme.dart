import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/_index.dart';
import 'package:prf_design/src/theme/extensions/_index.dart';
import 'package:prf_design/src/theme/prf_theme_config.dart';
import 'package:prf_design/src/theme/text_theme.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFTheme {
  PRFTheme._();

  static ThemeData light({
    required double scaleFactor,
    PRFThemeConfig config = PRFThemeConfig.prf,
  }) {
    final textTheme = PRFTextTheme.getLightTheme(scaleFactor: scaleFactor);

    return ThemeData(
      useMaterial3: true,
      primaryColor: config.primaryColor,
      scaffoldBackgroundColor: config.neutralPalette[0],
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        PRFColorsExtension.fromConfig(config, Brightness.light),
        PRFStatusExtension.light,
      ],
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: config.primaryColor,
        onPrimary: PRFColors.white,
        secondary: config.secondaryColor,
        onSecondary: config.primaryPalette[9],
        error: PRFColors.error,
        onError: PRFColors.white,
        surface: PRFColors.white,
        onSurface: config.primaryPalette[8],
        onSurfaceVariant: config.neutralPalette[6],
        outline: config.neutralPalette[3],
        shadow: const Color(0x12090B1F),
        surfaceContainerHighest: config.neutralPalette[1],
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: config.neutralPalette[0],
        foregroundColor: config.primaryColor,
        elevation: PRFElevationTokens.none,
        scrolledUnderElevation: PRFElevationTokens.none,
        centerTitle: false,
        surfaceTintColor: PRFColors.transparent,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: config.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: config.primaryColor,
          foregroundColor: PRFColors.white,
          disabledBackgroundColor: config.neutralPalette[3],
          disabledForegroundColor: config.neutralPalette[6],
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
          foregroundColor: config.primaryColor,
          side: BorderSide(color: config.neutralPalette[3], width: 1.2),
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
          foregroundColor: config.primaryColor,
          textStyle: PRFTextTheme.getButtonTextStyle(scaleFactor: scaleFactor),
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme(
        textTheme: textTheme,
        fillColor: PRFColors.white,
        outlineColor: config.neutralPalette[3],
        focusColor: config.primaryColor,
      ),
      cardTheme: CardThemeData(
        color: PRFColors.white,
        surfaceTintColor: PRFColors.transparent,
        shadowColor: const Color(0x12090B1F),
        elevation: PRFElevationTokens.sm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
          side: BorderSide(color: config.neutralPalette[2]),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: config.neutralPalette[2],
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.white,
        ),
        backgroundColor: config.primaryColor,
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
        backgroundColor: config.neutralPalette[1],
        selectedColor: config.primaryColor,
        disabledColor: config.neutralPalette[3],
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
        color: config.primaryColor,
        size: 22 * scaleFactor,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyMedium,
        inputDecorationTheme: _inputDecorationTheme(
          textTheme: textTheme,
          fillColor: PRFColors.white,
          outlineColor: config.neutralPalette[3],
          focusColor: config.primaryColor,
        ),
      ),
    );
  }

  static ThemeData dark({
    required double scaleFactor,
    PRFThemeConfig config = PRFThemeConfig.prf,
  }) {
    final textTheme = PRFTextTheme.getDarkTheme(scaleFactor: scaleFactor);

    return ThemeData(
      useMaterial3: true,
      primaryColor: config.secondaryColor,
      scaffoldBackgroundColor: config.primaryPalette[9],
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        PRFColorsExtension.fromConfig(config, Brightness.dark),
        PRFStatusExtension.dark,
      ],
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: config.secondaryColor,
        onPrimary: config.primaryPalette[9],
        secondary: config.primaryPalette[3],
        onSecondary: PRFColors.white,
        error: PRFStatusTokens.errorMainDark,
        onError: PRFColors.white,
        surface: config.primaryPalette[8],
        onSurface: PRFColors.white,
        onSurfaceVariant: config.neutralPalette[4],
        outline: config.neutralPalette[7],
        shadow: const Color(0x33000000),
        surfaceContainerHighest: config.primaryPalette[7],
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: config.primaryPalette[9],
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
          backgroundColor: config.secondaryColor,
          foregroundColor: config.primaryPalette[9],
          disabledBackgroundColor: config.neutralPalette[7],
          disabledForegroundColor: config.neutralPalette[5],
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
          side: BorderSide(color: config.neutralPalette[7]),
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
        fillColor: config.primaryPalette[8],
        outlineColor: config.neutralPalette[7],
        focusColor: config.secondaryColor,
      ),
      cardTheme: CardThemeData(
        color: config.primaryPalette[8],
        surfaceTintColor: PRFColors.transparent,
        shadowColor: const Color(0x33000000),
        elevation: PRFElevationTokens.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
          side: BorderSide(color: config.neutralPalette[7]),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: config.neutralPalette[7],
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: config.primaryPalette[9],
        ),
        backgroundColor: config.secondaryColor,
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
