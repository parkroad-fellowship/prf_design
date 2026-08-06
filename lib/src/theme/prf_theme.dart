import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/extensions/prf_colors_extension.dart';
import 'package:prf_design/src/theme/extensions/prf_status_extension.dart';
import 'package:prf_design/src/theme/text_theme.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// PRF brand theme factories.
///
/// Both brightness modes flow through a single [_build] that derives every
/// component theme from one [ColorScheme]. Raw [PRFColors] values are
/// referenced here and in [PRFTextTheme] only.
///
/// Consuming apps can theme the design system with their own palette in two
/// ways:
/// - pass [PRFBaseColors] via `colors` and let the theme derive a full
///   [ColorScheme] (on-colours and container roles come from Material 3
///   tonal palettes, neutral surfaces stay PRF), or
/// - pass a complete [ColorScheme] via `colorScheme` for full control.
/// When both are provided, `colorScheme` wins; when neither is, the
/// hand-authored PRF scheme for that brightness is used.
class PRFTheme {
  PRFTheme._();

  /// Builds a light [ThemeData]. Pass [colors] (base colours) or [colorScheme]
  /// (full scheme) to bring your own palette; otherwise the hand-authored PRF
  /// light scheme is used.
  static ThemeData light({
    required double scaleFactor,
    ColorScheme? colorScheme,
    PRFBaseColors? colors,
  }) => _build(
    scaleFactor: scaleFactor,
    scheme: colorScheme ?? _resolveScheme(Brightness.light, colors),
  );

  /// Builds a dark [ThemeData]. Pass [colors] (base colours) or [colorScheme]
  /// (full scheme) to bring your own palette; otherwise the hand-authored PRF
  /// dark scheme is used.
  static ThemeData dark({
    required double scaleFactor,
    ColorScheme? colorScheme,
    PRFBaseColors? colors,
  }) => _build(
    scaleFactor: scaleFactor,
    scheme: colorScheme ?? _resolveScheme(Brightness.dark, colors),
  );

  static ThemeData _build({
    required double scaleFactor,
    required ColorScheme scheme,
  }) {
    final isDark = scheme.brightness == Brightness.dark;
    final textTheme = isDark
        ? PRFTextTheme.getDarkTheme(scaleFactor: scaleFactor)
        : PRFTextTheme.getLightTheme(scaleFactor: scaleFactor);

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        if (isDark) PRFColorsExtension.dark else PRFColorsExtension.light,
        if (isDark) PRFStatusExtension.dark else PRFStatusExtension.light,
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: isDark ? scheme.onSurface : scheme.primary,
        elevation: PRFElevationTokens.none,
        scrolledUnderElevation: PRFElevationTokens.none,
        centerTitle: false,
        surfaceTintColor: PRFColors.transparent,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: isDark ? scheme.onSurface : scheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
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
          elevation: PRFElevationTokens.none,
          textStyle: PRFTextTheme.getButtonTextStyle(scaleFactor: scaleFactor),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.outline, width: 1.2),
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
          foregroundColor: scheme.primary,
          textStyle: PRFTextTheme.getButtonTextStyle(scaleFactor: scaleFactor),
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme(
        textTheme: textTheme,
        scheme: scheme,
        fillColor: isDark ? scheme.surfaceContainer : scheme.surface,
      ),
      cardTheme: CardThemeData(
        color: isDark ? scheme.surfaceContainer : scheme.surface,
        surfaceTintColor: PRFColors.transparent,
        shadowColor: scheme.shadow,
        elevation: isDark ? PRFElevationTokens.none : PRFElevationTokens.sm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? scheme.onSecondary : PRFColors.white,
        ),
        backgroundColor: isDark ? scheme.secondary : scheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
        ),
      ),
      chipTheme: ChipThemeData(
        labelStyle: textTheme.labelMedium,
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: scheme.onPrimary,
        ),
        backgroundColor: scheme.surfaceContainerHighest,
        selectedColor: scheme.primary,
        disabledColor: scheme.outlineVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: PRFColors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(PRFRadiusTokens.lg),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: scheme.primary,
        size: 22 * scaleFactor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHighest,
        circularTrackColor: scheme.surfaceContainerHighest,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        surfaceTintColor: PRFColors.transparent,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyMedium,
        inputDecorationTheme: _inputDecorationTheme(
          textTheme: textTheme,
          scheme: scheme,
          fillColor: scheme.surface,
        ),
      ),
    );
  }

  /// Hand-authored Material 3 scheme. No index-flipping: each brightness has
  /// its own deliberately chosen surface/container roles.
  static ColorScheme _colorScheme(Brightness brightness) {
    if (brightness == Brightness.light) {
      return const ColorScheme(
        brightness: Brightness.light,
        primary: PRFColors.navy500,
        onPrimary: PRFColors.white,
        primaryContainer: PRFColors.navy50,
        onPrimaryContainer: PRFColors.navy900,
        secondary: PRFColors.lime500,
        onSecondary: PRFColors.navy900,
        secondaryContainer: PRFColors.lime50,
        onSecondaryContainer: PRFColors.navy900,
        tertiary: PRFColors.lime500,
        onTertiary: PRFColors.navy900,
        error: PRFColors.error,
        onError: PRFColors.white,
        errorContainer: PRFColors.errorLight,
        onErrorContainer: PRFColors.errorDark,
        surface: PRFColors.white,
        onSurface: PRFColors.gray900,
        onSurfaceVariant: PRFColors.gray600,
        outline: PRFColors.gray300,
        outlineVariant: PRFColors.gray200,
        shadow: Color(0x12090B1F),
        surfaceContainerLowest: PRFColors.white,
        surfaceContainerLow: PRFColors.gray50,
        surfaceContainer: PRFColors.gray100,
        surfaceContainerHigh: PRFColors.gray200,
        surfaceContainerHighest: PRFColors.gray300,
        inverseSurface: PRFColors.gray800,
        onInverseSurface: PRFColors.white,
      );
    }
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: PRFColors.navy200,
      onPrimary: PRFColors.navy900,
      primaryContainer: PRFColors.navy800,
      onPrimaryContainer: PRFColors.navy100,
      secondary: PRFColors.lime400,
      onSecondary: PRFColors.navy900,
      secondaryContainer: PRFColors.lime900,
      onSecondaryContainer: PRFColors.lime100,
      tertiary: PRFColors.lime400,
      onTertiary: PRFColors.navy900,
      error: PRFStatusTokens.errorMainDark,
      onError: PRFColors.white,
      errorContainer: PRFStatusTokens.errorBackgroundDark,
      onErrorContainer: PRFColors.errorLight,
      surface: PRFColors.navy900,
      onSurface: PRFColors.gray100,
      onSurfaceVariant: PRFColors.gray400,
      outline: PRFColors.gray600,
      outlineVariant: PRFColors.gray700,
      shadow: Color(0x33000000),
      surfaceContainerLowest: PRFColors.navy900,
      surfaceContainerLow: PRFColors.navy800,
      surfaceContainer: PRFColors.navy800,
      surfaceContainerHigh: PRFColors.navy700,
      surfaceContainerHighest: PRFColors.navy700,
      inverseSurface: PRFColors.gray200,
      onInverseSurface: PRFColors.navy900,
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    required TextTheme textTheme,
    required ColorScheme scheme,
    required Color fillColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
      labelStyle: textTheme.bodyMedium?.copyWith(
        color: scheme.onSurfaceVariant,
      ),
      floatingLabelStyle: textTheme.labelMedium?.copyWith(
        color: scheme.primary,
      ),
      errorStyle: textTheme.bodySmall?.copyWith(color: scheme.error),
      prefixIconColor: scheme.onSurfaceVariant,
      suffixIconColor: scheme.onSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: PRFSpacingTokens.lg,
        vertical: PRFSpacingTokens.md,
      ),
      border: _inputBorder(scheme.outlineVariant),
      enabledBorder: _inputBorder(scheme.outlineVariant),
      focusedBorder: _inputBorder(scheme.primary, width: 1.8),
      errorBorder: _inputBorder(scheme.error),
      focusedErrorBorder: _inputBorder(scheme.error, width: 1.8),
      disabledBorder: _inputBorder(
        scheme.outlineVariant.withValues(alpha: 0.55),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  /// Returns the PRF scheme for [brightness], or a scheme derived from the
  /// provided [PRFBaseColors].
  static ColorScheme _resolveScheme(
    Brightness brightness,
    PRFBaseColors? colors,
  ) {
    if (colors == null) return _colorScheme(brightness);
    return _deriveScheme(brightness: brightness, colors: colors);
  }

  /// Builds a [ColorScheme] from base colours: the supplied roles are used
  /// verbatim, their on-colours and container roles come from the Material 3
  /// tonal palette seeded with each colour, and PRF neutral surfaces/outlines
  /// are kept. Unset roles fall back to the hand-authored PRF scheme.
  static ColorScheme _deriveScheme({
    required Brightness brightness,
    required PRFBaseColors colors,
  }) {
    final base = _colorScheme(brightness);

    ColorScheme seeded(Color seed) =>
        ColorScheme.fromSeed(seedColor: seed, brightness: brightness);

    final primary = colors.primary ?? base.primary;
    final secondary = colors.secondary ?? base.secondary;
    final tertiary = colors.tertiary ?? base.tertiary;
    final error = colors.error ?? base.error;

    final primarySeed = seeded(primary);
    final secondarySeed = seeded(secondary);
    final tertiarySeed = seeded(tertiary);

    // fromSeed derives error roles from the standard error palette, not the
    // seed, so a custom error colour needs luminance-based on-colour/container.
    final errorContainer = _errorContainer(error, brightness);

    return base.copyWith(
      primary: primary,
      onPrimary: colors.primary != null
          ? primarySeed.onPrimary
          : base.onPrimary,
      primaryContainer: colors.primary != null
          ? primarySeed.primaryContainer
          : base.primaryContainer,
      onPrimaryContainer: colors.primary != null
          ? primarySeed.onPrimaryContainer
          : base.onPrimaryContainer,
      secondary: secondary,
      onSecondary: colors.secondary != null
          ? secondarySeed.onSecondary
          : base.onSecondary,
      secondaryContainer: colors.secondary != null
          ? secondarySeed.secondaryContainer
          : base.secondaryContainer,
      onSecondaryContainer: colors.secondary != null
          ? secondarySeed.onSecondaryContainer
          : base.onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: colors.tertiary != null
          ? tertiarySeed.onTertiary
          : base.onTertiary,
      error: error,
      onError: colors.error != null ? _onColor(error) : base.onError,
      errorContainer: colors.error != null
          ? errorContainer
          : base.errorContainer,
      onErrorContainer: colors.error != null
          ? _onColor(errorContainer)
          : base.onErrorContainer,
    );
  }

  /// Picks a readable foreground for [background]: white on dark colours,
  /// near-black on light colours.
  static Color _onColor(Color background) {
    return background.computeLuminance() > 0.5
        ? const Color(0xFF1A1A1A)
        : const Color(0xFFFFFFFF);
  }

  /// Lightens (light mode) or darkens (dark mode) [base] into a container role.
  static Color _errorContainer(Color base, Brightness brightness) {
    final mix = brightness == Brightness.dark
        ? const Color(0xFF000000)
        : const Color(0xFFFFFFFF);
    return Color.alphaBlend(mix.withValues(alpha: 0.85), base);
  }
}

/// Base brand colours a consuming app can pass to [PRFTheme.light] /
/// [PRFTheme.dark]. Any role left null keeps the hand-authored PRF value.
/// On-colours and container roles are derived by the theme from these colours.
class PRFBaseColors {
  const PRFBaseColors({
    this.primary,
    this.secondary,
    this.tertiary,
    this.error,
  });

  /// Primary brand colour.
  final Color? primary;

  /// Secondary brand colour.
  final Color? secondary;

  /// Tertiary accent colour.
  final Color? tertiary;

  /// Error/semantic failure colour.
  final Color? error;
}
