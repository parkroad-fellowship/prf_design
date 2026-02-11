import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/_index.dart';

/// ThemeExtension providing access to PRF brand colors.
///
/// Access via BuildContext:
/// ```dart
/// final colors = Theme.of(context).extension<PRFColorsExtension>()!;
/// // or with convenience extension:
/// final colors = context.prfColors;
/// ```
@immutable
class PRFColorsExtension extends ThemeExtension<PRFColorsExtension> {
  const PRFColorsExtension({
    // Brand colors
    required this.navyBlue,
    required this.limeGreen,
    // Navy palette
    required this.navy50,
    required this.navy100,
    required this.navy200,
    required this.navy300,
    required this.navy400,
    required this.navy500,
    required this.navy600,
    required this.navy700,
    required this.navy800,
    required this.navy900,
    // Lime palette
    required this.lime50,
    required this.lime100,
    required this.lime200,
    required this.lime300,
    required this.lime400,
    required this.lime500,
    required this.lime600,
    required this.lime700,
    required this.lime800,
    required this.lime900,
    // Neutrals
    required this.gray50,
    required this.gray100,
    required this.gray200,
    required this.gray300,
    required this.gray400,
    required this.gray500,
    required this.gray600,
    required this.gray700,
    required this.gray800,
    required this.gray900,
    // Accent colors
    required this.purple,
    required this.blue,
    required this.orange,
    required this.emerald,
  });

  // Brand colors
  final Color navyBlue;
  final Color limeGreen;

  // Navy palette
  final Color navy50;
  final Color navy100;
  final Color navy200;
  final Color navy300;
  final Color navy400;
  final Color navy500;
  final Color navy600;
  final Color navy700;
  final Color navy800;
  final Color navy900;

  // Lime palette
  final Color lime50;
  final Color lime100;
  final Color lime200;
  final Color lime300;
  final Color lime400;
  final Color lime500;
  final Color lime600;
  final Color lime700;
  final Color lime800;
  final Color lime900;

  // Neutrals
  final Color gray50;
  final Color gray100;
  final Color gray200;
  final Color gray300;
  final Color gray400;
  final Color gray500;
  final Color gray600;
  final Color gray700;
  final Color gray800;
  final Color gray900;

  // Accent colors
  final Color purple;
  final Color blue;
  final Color orange;
  final Color emerald;

  /// Light theme instance
  static const light = PRFColorsExtension(
    // Brand colors
    navyBlue: PRFColors.navyBlue,
    limeGreen: PRFColors.limeGreen,
    // Navy palette
    navy50: PRFColorPalette.navy50,
    navy100: PRFColorPalette.navy100,
    navy200: PRFColorPalette.navy200,
    navy300: PRFColorPalette.navy300,
    navy400: PRFColorPalette.navy400,
    navy500: PRFColorPalette.navy500,
    navy600: PRFColorPalette.navy600,
    navy700: PRFColorPalette.navy700,
    navy800: PRFColorPalette.navy800,
    navy900: PRFColorPalette.navy900,
    // Lime palette
    lime50: PRFColorPalette.lime50,
    lime100: PRFColorPalette.lime100,
    lime200: PRFColorPalette.lime200,
    lime300: PRFColorPalette.lime300,
    lime400: PRFColorPalette.lime400,
    lime500: PRFColorPalette.lime500,
    lime600: PRFColorPalette.lime600,
    lime700: PRFColorPalette.lime700,
    lime800: PRFColorPalette.lime800,
    lime900: PRFColorPalette.lime900,
    // Neutrals
    gray50: PRFColors.gray50,
    gray100: PRFColors.gray100,
    gray200: PRFColors.gray200,
    gray300: PRFColors.gray300,
    gray400: PRFColors.gray400,
    gray500: PRFColors.gray500,
    gray600: PRFColors.gray600,
    gray700: PRFColors.gray700,
    gray800: PRFColors.gray800,
    gray900: PRFColors.gray900,
    // Accent colors
    purple: PRFColors.purple,
    blue: PRFColors.blue,
    orange: PRFColors.orange,
    emerald: PRFColors.emerald,
  );

  /// Dark theme instance (inverted for dark mode)
  static const dark = PRFColorsExtension(
    // Brand colors - slightly lighter versions for dark mode
    navyBlue: PRFColorPalette.navy300,
    limeGreen: PRFColorPalette.lime400,
    // Navy palette - inverted
    navy50: PRFColorPalette.navy900,
    navy100: PRFColorPalette.navy800,
    navy200: PRFColorPalette.navy700,
    navy300: PRFColorPalette.navy600,
    navy400: PRFColorPalette.navy500,
    navy500: PRFColorPalette.navy400,
    navy600: PRFColorPalette.navy300,
    navy700: PRFColorPalette.navy200,
    navy800: PRFColorPalette.navy100,
    navy900: PRFColorPalette.navy50,
    // Lime palette - inverted
    lime50: PRFColorPalette.lime900,
    lime100: PRFColorPalette.lime800,
    lime200: PRFColorPalette.lime700,
    lime300: PRFColorPalette.lime600,
    lime400: PRFColorPalette.lime500,
    lime500: PRFColorPalette.lime400,
    lime600: PRFColorPalette.lime300,
    lime700: PRFColorPalette.lime200,
    lime800: PRFColorPalette.lime100,
    lime900: PRFColorPalette.lime50,
    // Neutrals - inverted
    gray50: PRFColors.gray900,
    gray100: PRFColors.gray800,
    gray200: PRFColors.gray700,
    gray300: PRFColors.gray600,
    gray400: PRFColors.gray500,
    gray500: PRFColors.gray400,
    gray600: PRFColors.gray300,
    gray700: PRFColors.gray200,
    gray800: PRFColors.gray100,
    gray900: PRFColors.gray50,
    // Accent colors - same for dark mode
    purple: PRFColors.purple,
    blue: PRFColors.blue,
    orange: PRFColors.orange,
    emerald: PRFColors.emerald,
  );

  @override
  PRFColorsExtension copyWith({
    Color? navyBlue,
    Color? limeGreen,
    Color? navy50,
    Color? navy100,
    Color? navy200,
    Color? navy300,
    Color? navy400,
    Color? navy500,
    Color? navy600,
    Color? navy700,
    Color? navy800,
    Color? navy900,
    Color? lime50,
    Color? lime100,
    Color? lime200,
    Color? lime300,
    Color? lime400,
    Color? lime500,
    Color? lime600,
    Color? lime700,
    Color? lime800,
    Color? lime900,
    Color? gray50,
    Color? gray100,
    Color? gray200,
    Color? gray300,
    Color? gray400,
    Color? gray500,
    Color? gray600,
    Color? gray700,
    Color? gray800,
    Color? gray900,
    Color? purple,
    Color? blue,
    Color? orange,
    Color? emerald,
  }) {
    return PRFColorsExtension(
      navyBlue: navyBlue ?? this.navyBlue,
      limeGreen: limeGreen ?? this.limeGreen,
      navy50: navy50 ?? this.navy50,
      navy100: navy100 ?? this.navy100,
      navy200: navy200 ?? this.navy200,
      navy300: navy300 ?? this.navy300,
      navy400: navy400 ?? this.navy400,
      navy500: navy500 ?? this.navy500,
      navy600: navy600 ?? this.navy600,
      navy700: navy700 ?? this.navy700,
      navy800: navy800 ?? this.navy800,
      navy900: navy900 ?? this.navy900,
      lime50: lime50 ?? this.lime50,
      lime100: lime100 ?? this.lime100,
      lime200: lime200 ?? this.lime200,
      lime300: lime300 ?? this.lime300,
      lime400: lime400 ?? this.lime400,
      lime500: lime500 ?? this.lime500,
      lime600: lime600 ?? this.lime600,
      lime700: lime700 ?? this.lime700,
      lime800: lime800 ?? this.lime800,
      lime900: lime900 ?? this.lime900,
      gray50: gray50 ?? this.gray50,
      gray100: gray100 ?? this.gray100,
      gray200: gray200 ?? this.gray200,
      gray300: gray300 ?? this.gray300,
      gray400: gray400 ?? this.gray400,
      gray500: gray500 ?? this.gray500,
      gray600: gray600 ?? this.gray600,
      gray700: gray700 ?? this.gray700,
      gray800: gray800 ?? this.gray800,
      gray900: gray900 ?? this.gray900,
      purple: purple ?? this.purple,
      blue: blue ?? this.blue,
      orange: orange ?? this.orange,
      emerald: emerald ?? this.emerald,
    );
  }

  @override
  PRFColorsExtension lerp(PRFColorsExtension? other, double t) {
    if (other is! PRFColorsExtension) return this;
    return PRFColorsExtension(
      navyBlue: Color.lerp(navyBlue, other.navyBlue, t)!,
      limeGreen: Color.lerp(limeGreen, other.limeGreen, t)!,
      navy50: Color.lerp(navy50, other.navy50, t)!,
      navy100: Color.lerp(navy100, other.navy100, t)!,
      navy200: Color.lerp(navy200, other.navy200, t)!,
      navy300: Color.lerp(navy300, other.navy300, t)!,
      navy400: Color.lerp(navy400, other.navy400, t)!,
      navy500: Color.lerp(navy500, other.navy500, t)!,
      navy600: Color.lerp(navy600, other.navy600, t)!,
      navy700: Color.lerp(navy700, other.navy700, t)!,
      navy800: Color.lerp(navy800, other.navy800, t)!,
      navy900: Color.lerp(navy900, other.navy900, t)!,
      lime50: Color.lerp(lime50, other.lime50, t)!,
      lime100: Color.lerp(lime100, other.lime100, t)!,
      lime200: Color.lerp(lime200, other.lime200, t)!,
      lime300: Color.lerp(lime300, other.lime300, t)!,
      lime400: Color.lerp(lime400, other.lime400, t)!,
      lime500: Color.lerp(lime500, other.lime500, t)!,
      lime600: Color.lerp(lime600, other.lime600, t)!,
      lime700: Color.lerp(lime700, other.lime700, t)!,
      lime800: Color.lerp(lime800, other.lime800, t)!,
      lime900: Color.lerp(lime900, other.lime900, t)!,
      gray50: Color.lerp(gray50, other.gray50, t)!,
      gray100: Color.lerp(gray100, other.gray100, t)!,
      gray200: Color.lerp(gray200, other.gray200, t)!,
      gray300: Color.lerp(gray300, other.gray300, t)!,
      gray400: Color.lerp(gray400, other.gray400, t)!,
      gray500: Color.lerp(gray500, other.gray500, t)!,
      gray600: Color.lerp(gray600, other.gray600, t)!,
      gray700: Color.lerp(gray700, other.gray700, t)!,
      gray800: Color.lerp(gray800, other.gray800, t)!,
      gray900: Color.lerp(gray900, other.gray900, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      emerald: Color.lerp(emerald, other.emerald, t)!,
    );
  }
}
