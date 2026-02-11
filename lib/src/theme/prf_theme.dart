import 'package:flutter/material.dart';
import 'package:prf_design_system/src/theme/colors/_index.dart';
import 'package:prf_design_system/src/theme/extensions/_index.dart';
import 'package:prf_design_system/src/theme/text_theme.dart';
import 'package:prf_design_system/src/utils/device_helper.dart';

class PRFTheme {
  PRFTheme._();

  static ThemeData light(BuildContext context) {
    final textTheme = PRFTextTheme.getLightTheme(context);
    final scaleFactor = DeviceHelper.getScaleFactor(context);

    return ThemeData(
      useMaterial3: true,
      primaryColor: PRFColors.navyBlue,
      scaffoldBackgroundColor: PRFColors.white,

      // Theme extensions
      extensions: const <ThemeExtension<dynamic>>[
        PRFColorsExtension.light,
        PRFStatusExtension.light,
      ],

      // Text theme
      textTheme: textTheme,

      colorScheme: const ColorScheme(
        primary: PRFColors.navyBlue,
        secondary: PRFColors.limeGreen,
        surface: PRFColors.white,
        surfaceContainerHighest: PRFColors.gray50,
        error: PRFColors.error,
        onPrimary: PRFColors.white,
        onSecondary: PRFColors.black,
        onSurface: PRFColors.black,
        onSurfaceVariant: PRFColors.gray600,
        onError: PRFColors.white,
        outline: PRFColors.gray300,
        shadow: Color(0x1F000000),
        brightness: Brightness.light,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: PRFColors.white,
        foregroundColor: PRFColors.navyBlue,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: PRFColors.transparent,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: PRFColors.navyBlue,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PRFColors.navyBlue,
          foregroundColor: PRFColors.white,
          disabledBackgroundColor: PRFColors.navyBlue.withValues(alpha: 0.4),
          disabledForegroundColor: PRFColors.white.withValues(alpha: 0.7),
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          shadowColor: const Color(0x1F000000),
          textStyle: PRFTextTheme.getButtonTextStyle(context).copyWith(
            color: PRFColors.white,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PRFColors.navyBlue,
          side: const BorderSide(color: PRFColors.navyBlue, width: 1.5),
          disabledForegroundColor: PRFColors.navyBlue.withValues(alpha: 0.4),
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: PRFTextTheme.getButtonTextStyle(context).copyWith(
            color: PRFColors.navyBlue,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PRFColors.navyBlue,
          textStyle: PRFTextTheme.getButtonTextStyle(context).copyWith(
            color: PRFColors.navyBlue,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PRFColors.gray50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.gray300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.gray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.navyBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: PRFColors.gray300.withValues(alpha: 0.5),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.gray600,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.gray600,
        ),
        errorStyle: PRFTextTheme.getErrorTextStyle(context),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        surfaceTintColor: PRFColors.transparent,
        elevation: 4,
        shadowColor: Color(0x1F000000),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: PRFColors.gray300,
        thickness: 1,
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarThemeData(
        labelStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: PRFColors.navyBlue,
        ),
        unselectedLabelStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: PRFColors.gray600,
        ),
        dividerColor: PRFColors.white,
        tabAlignment: TabAlignment.start,
        indicatorColor: PRFColors.white,
        overlayColor: WidgetStateProperty.all(PRFColors.transparent),
      ),

      // Data Table Theme
      dataTableTheme: DataTableThemeData(
        dataTextStyle: textTheme.bodyMedium,
        headingTextStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.white,
        ),
        backgroundColor: PRFColors.navyBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        size: 24 * scaleFactor,
        color: PRFColors.navyBlue,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        titleTextStyle: textTheme.bodyLarge,
        subtitleTextStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.gray600,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        labelStyle: textTheme.labelMedium,
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: PRFColors.white,
        ),
        backgroundColor: PRFColors.gray50,
        selectedColor: PRFColors.navyBlue,
        disabledColor: PRFColors.gray300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Dropdown Menu Theme
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyMedium,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: PRFColors.gray50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: PRFColors.gray300),
          ),
        ),
      ),
    );
  }

  static ThemeData dark(BuildContext context) {
    final textTheme = PRFTextTheme.getDarkTheme(context);
    final scaleFactor = DeviceHelper.getScaleFactor(context);

    return ThemeData(
      useMaterial3: true,
      primaryColor: PRFColors.navyBlue,
      scaffoldBackgroundColor: PRFColors.gray900,

      // Theme extensions
      extensions: const <ThemeExtension<dynamic>>[
        PRFColorsExtension.dark,
        PRFStatusExtension.dark,
      ],

      // Text theme
      textTheme: textTheme,

      colorScheme: const ColorScheme(
        primary: PRFColors.limeGreen,
        secondary: PRFColors.navyBlue,
        surface: PRFColors.gray800,
        surfaceContainerHighest: PRFColors.gray700,
        error: PRFColors.error,
        onPrimary: PRFColors.black,
        onSecondary: PRFColors.white,
        onSurface: PRFColors.white,
        onSurfaceVariant: PRFColors.gray400,
        onError: PRFColors.white,
        outline: PRFColors.gray600,
        shadow: Color(0x3F000000),
        brightness: Brightness.dark,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: PRFColors.gray900,
        foregroundColor: PRFColors.white,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: PRFColors.transparent,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: PRFColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PRFColors.limeGreen,
          foregroundColor: PRFColors.black,
          disabledBackgroundColor: PRFColors.limeGreen.withValues(alpha: 0.4),
          disabledForegroundColor: PRFColors.black.withValues(alpha: 0.7),
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          shadowColor: const Color(0x3F000000),
          textStyle: PRFTextTheme.getButtonTextStyle(context).copyWith(
            color: PRFColors.black,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PRFColors.limeGreen,
          side: const BorderSide(color: PRFColors.limeGreen, width: 1.5),
          disabledForegroundColor: PRFColors.limeGreen.withValues(alpha: 0.4),
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: PRFTextTheme.getButtonTextStyle(context).copyWith(
            color: PRFColors.limeGreen,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PRFColors.limeGreen,
          textStyle: PRFTextTheme.getButtonTextStyle(context).copyWith(
            color: PRFColors.limeGreen,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PRFColors.gray800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.gray600),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.gray600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.limeGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PRFColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: PRFColors.gray600.withValues(alpha: 0.5),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.gray500,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.gray400,
        ),
        errorStyle: PRFTextTheme.getErrorTextStyle(context),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        color: PRFColors.gray800,
        surfaceTintColor: PRFColors.transparent,
        elevation: 4,
        shadowColor: Color(0x3F000000),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: PRFColors.gray700,
        thickness: 1,
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarThemeData(
        labelStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: PRFColors.limeGreen,
        ),
        unselectedLabelStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: PRFColors.gray500,
        ),
        dividerColor: PRFColors.gray800,
        tabAlignment: TabAlignment.start,
        indicatorColor: PRFColors.limeGreen,
        overlayColor: WidgetStateProperty.all(PRFColors.transparent),
      ),

      // Data Table Theme
      dataTableTheme: DataTableThemeData(
        dataTextStyle: textTheme.bodyMedium,
        headingTextStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.black,
        ),
        backgroundColor: PRFColors.limeGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        size: 24 * scaleFactor,
        color: PRFColors.white,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: PRFColors.gray800,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        titleTextStyle: textTheme.bodyLarge,
        subtitleTextStyle: textTheme.bodyMedium?.copyWith(
          color: PRFColors.gray400,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        labelStyle: textTheme.labelMedium,
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: PRFColors.black,
        ),
        backgroundColor: PRFColors.gray700,
        selectedColor: PRFColors.limeGreen,
        disabledColor: PRFColors.gray600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Dropdown Menu Theme
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyMedium,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: PRFColors.gray800,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: PRFColors.gray600),
          ),
        ),
      ),
    );
  }
}
