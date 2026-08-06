import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/extensions/prf_colors_extension.dart';
import 'package:prf_design/src/theme/extensions/prf_status_extension.dart';
import 'package:prf_design/src/theme/prf_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PRFTheme', () {
    test('light can be built with explicit scaleFactor', () {
      final theme = PRFTheme.light(scaleFactor: 1);

      expect(theme.useMaterial3, isTrue);
      expect(theme.extensions[PRFColorsExtension], isNotNull);
      expect(theme.extensions[PRFStatusExtension], isNotNull);
    });

    test('dark can be built with explicit scaleFactor', () {
      final theme = PRFTheme.dark(scaleFactor: 1);

      expect(theme.useMaterial3, isTrue);
      expect(theme.extensions[PRFColorsExtension], isNotNull);
      expect(theme.extensions[PRFStatusExtension], isNotNull);
    });

    test('light adopts a caller-supplied colorScheme', () {
      const custom = ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF112233),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF445566),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFF990000),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFEFEFE),
        onSurface: Color(0xFF1A1A1A),
      );

      final theme = PRFTheme.light(scaleFactor: 1, colorScheme: custom);

      expect(theme.colorScheme.primary, equals(custom.primary));
      expect(theme.colorScheme.surface, equals(custom.surface));
      expect(theme.scaffoldBackgroundColor, equals(custom.surface));
      expect(theme.appBarTheme.backgroundColor, equals(custom.surface));
    });

    test('dark adopts a caller-supplied colorScheme', () {
      const custom = ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFAABBCC),
        onPrimary: Color(0xFF000000),
        secondary: Color(0xFF778899),
        onSecondary: Color(0xFF000000),
        error: Color(0xFFCC0000),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFF050505),
        onSurface: Color(0xFFE0E0E0),
      );

      final theme = PRFTheme.dark(scaleFactor: 1, colorScheme: custom);

      expect(theme.colorScheme.primary, equals(custom.primary));
      expect(theme.colorScheme.surface, equals(custom.surface));
      expect(theme.scaffoldBackgroundColor, equals(custom.surface));
      expect(theme.extensions[PRFColorsExtension], isNotNull);
    });

    group('base colours', () {
      const brandPrimary = Color(0xFF123456);

      test('light derives a scheme from PRFBaseColors', () {
        final theme = PRFTheme.light(
          scaleFactor: 1,
          colors: const PRFBaseColors(primary: brandPrimary),
        );

        expect(theme.colorScheme.primary, equals(brandPrimary));
        expect(theme.colorScheme.secondary, isNot(equals(brandPrimary)));
        expect(theme.colorScheme.surface, equals(PRFColors.white));
        expect(theme.colorScheme.onSurface, equals(PRFColors.gray900));
      });

      test('dark derives a scheme from PRFBaseColors', () {
        final theme = PRFTheme.dark(
          scaleFactor: 1,
          colors: const PRFBaseColors(primary: brandPrimary),
        );

        expect(theme.colorScheme.primary, equals(brandPrimary));
        expect(theme.colorScheme.surface, equals(PRFColors.navy900));
        expect(theme.scaffoldBackgroundColor, equals(PRFColors.navy900));
      });

      test('overrides every supplied base role', () {
        const secondary = Color(0xFFABCDEF);
        const tertiary = Color(0xFFFEDCBA);
        const error = Color(0xFFAA2222);

        final theme = PRFTheme.light(
          scaleFactor: 1,
          colors: const PRFBaseColors(
            primary: brandPrimary,
            secondary: secondary,
            tertiary: tertiary,
            error: error,
          ),
        );

        expect(theme.colorScheme.primary, equals(brandPrimary));
        expect(theme.colorScheme.secondary, equals(secondary));
        expect(theme.colorScheme.tertiary, equals(tertiary));
        expect(theme.colorScheme.error, equals(error));
      });

      test('colorScheme takes precedence over colors', () {
        const custom = ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF112233),
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFF445566),
          onSecondary: Color(0xFFFFFFFF),
          error: Color(0xFF990000),
          onError: Color(0xFFFFFFFF),
          surface: Color(0xFFFEFEFE),
          onSurface: Color(0xFF1A1A1A),
        );

        final theme = PRFTheme.light(
          scaleFactor: 1,
          colorScheme: custom,
          colors: const PRFBaseColors(primary: brandPrimary),
        );

        expect(theme.colorScheme.primary, equals(custom.primary));
        expect(theme.colorScheme.surface, equals(custom.surface));
      });
    });
  });
}
