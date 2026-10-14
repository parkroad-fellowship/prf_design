import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/theme/extensions/prf_status_extension.dart';
import 'package:prf_design/src/theme/prf_theme.dart';

/// WCAG 2.x relative luminance, implemented independently of Flutter's
/// `computeLuminance` so the test checks the formula, not the framework.
double _luminance(Color c) {
  double channel(double v) =>
      v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * channel(c.r) + 0.7152 * channel(c.g) + 0.0722 * channel(c.b);
}

double _contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

Matcher _atLeast(double min) => greaterThanOrEqualTo(min);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('luminance formula sanity: black on white is 21:1', () {
    expect(
      _contrast(const Color(0xFF000000), const Color(0xFFFFFFFF)),
      closeTo(21, 0.01),
    );
  });

  for (final brightness in Brightness.values) {
    final name = brightness.name;
    final theme = brightness == Brightness.light
        ? PRFTheme.light(scaleFactor: 1)
        : PRFTheme.dark(scaleFactor: 1);
    final scheme = theme.colorScheme;
    final status = theme.extension<PRFStatusExtension>()!;

    group('$name theme', () {
      final statusSets = <String, StatusColorSet>{
        'success': status.success,
        'warning': status.warning,
        'error': status.error,
        'info': status.info,
        'pending': status.pending,
        'initiated': status.initiated,
        'scheduled': status.scheduled,
        'inProgress': status.inProgress,
        'completed': status.completed,
        'failed': status.failed,
        'ignored': status.ignored,
      };

      for (final entry in statusSets.entries) {
        final set = entry.value;
        test('${entry.key}: onColor on main ≥ 4.5', () {
          expect(_contrast(set.onColor, set.main), _atLeast(4.5));
        });
        test('${entry.key}: foreground on background ≥ 4.5', () {
          expect(_contrast(set.foreground, set.background), _atLeast(4.5));
        });
        test('${entry.key}: onColorFor(main) returns the safe pair', () {
          expect(status.onColorFor(set.main), set.onColor);
        });
      }

      final textPairs = <String, (Color, Color)>{
        'onPrimary/primary': (scheme.onPrimary, scheme.primary),
        'onSurface/surface': (scheme.onSurface, scheme.surface),
        'onSurfaceVariant/surface': (scheme.onSurfaceVariant, scheme.surface),
        'onSecondary/secondary': (scheme.onSecondary, scheme.secondary),
        'onError/error': (scheme.onError, scheme.error),
        'onErrorContainer/errorContainer': (
          scheme.onErrorContainer,
          scheme.errorContainer,
        ),
        'onInverseSurface/inverseSurface (tooltip)': (
          scheme.onInverseSurface,
          scheme.inverseSurface,
        ),
        'snackbar text/background': (
          theme.snackBarTheme.contentTextStyle!.color!,
          theme.snackBarTheme.backgroundColor!,
        ),
      };

      for (final entry in textPairs.entries) {
        test('${entry.key} ≥ 4.5', () {
          final (fg, bg) = entry.value;
          expect(_contrast(fg, bg), _atLeast(4.5));
        });
      }

      test('enabled input border ≥ 3.0 against field fill and surface', () {
        final input = theme.inputDecorationTheme;
        final border = input.enabledBorder!.borderSide.color;
        expect(_contrast(border, input.fillColor!), _atLeast(3));
        expect(_contrast(border, scheme.surface), _atLeast(3));
      });

      test('unselected checkbox border ≥ 3.0 against surface', () {
        final resolved = WidgetStateProperty.resolveAs<BorderSide?>(
          theme.checkboxTheme.side,
          <WidgetState>{},
        );
        expect(_contrast(resolved!.color, scheme.surface), _atLeast(3));
      });

      test('unselected radio ≥ 3.0 against surface', () {
        final fill = theme.radioTheme.fillColor!.resolve(<WidgetState>{})!;
        expect(_contrast(fill, scheme.surface), _atLeast(3));
      });

      test('interactive component themes keep 48dp tap targets', () {
        expect(
          theme.checkboxTheme.materialTapTargetSize,
          MaterialTapTargetSize.padded,
        );
        expect(
          theme.radioTheme.materialTapTargetSize,
          MaterialTapTargetSize.padded,
        );
        expect(
          theme.switchTheme.materialTapTargetSize,
          MaterialTapTargetSize.padded,
        );
        expect(theme.listTileTheme.minTileHeight, greaterThanOrEqualTo(48));
      });
    });
  }
}
