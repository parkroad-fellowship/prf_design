import 'package:flutter/material.dart';
import 'package:prf_design_system/src/theme/extensions/prf_colors_extension.dart';
import 'package:prf_design_system/src/theme/extensions/prf_status_extension.dart';

/// Convenience extensions on BuildContext for easy theme access.
extension PRFThemeContextExtensions on BuildContext {
  /// Access the PRF brand colors extension.
  ///
  /// Usage:
  /// ```dart
  /// final navy = context.prfColors.navyBlue;
  /// final lime = context.prfColors.limeGreen;
  /// ```
  PRFColorsExtension get prfColors =>
      Theme.of(this).extension<PRFColorsExtension>() ??
      PRFColorsExtension.light;

  /// Access the PRF status colors extension.
  ///
  /// Usage:
  /// ```dart
  /// final successColor = context.statusColors.success.main;
  /// final errorBg = context.statusColors.error.background;
  /// ```
  PRFStatusExtension get statusColors =>
      Theme.of(this).extension<PRFStatusExtension>() ??
      PRFStatusExtension.light;

  /// Quick access to the ColorScheme.
  ///
  /// Usage:
  /// ```dart
  /// final primary = context.colorScheme.primary;
  /// ```
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Quick access to the TextTheme.
  ///
  /// Usage:
  /// ```dart
  /// final headline = context.textTheme.headlineMedium;
  /// ```
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Quick access to the current Theme.
  ///
  /// Usage:
  /// ```dart
  /// final theme = context.theme;
  /// ```
  ThemeData get theme => Theme.of(this);
}
