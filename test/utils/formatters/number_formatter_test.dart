import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/utils/formatters/number_formatter.dart';

void main() {
  group('NumberFormatter', () {
    group('formatCash', () {
      test('formats integer amount with default settings', () {
        final result = NumberFormatter.formatCash(1000);
        expect(result, isNotEmpty);
        expect(result, contains('1'));
      });

      test('formats zero amount', () {
        final result = NumberFormatter.formatCash(0);
        expect(result, isNotEmpty);
        expect(result, contains('0'));
      });

      test('formats negative amount', () {
        final result = NumberFormatter.formatCash(-500);
        expect(result, contains('500'));
      });

      test('formats large amount', () {
        final result = NumberFormatter.formatCash(1000000);
        expect(result, isNotEmpty);
      });

      test('uses custom symbol when provided', () {
        final result = NumberFormatter.formatCash(
          100,
          customSymbol: r'$',
        );
        expect(result, contains(r'$'));
      });

      test('respects decimalDigits parameter', () {
        final result = NumberFormatter.formatCash(
          100.5,
          decimalDigits: 2,
        );
        expect(result, contains('.'));
      });
    });

    group('truncateToDecimalPlaces', () {
      test('truncates to 2 decimal places', () {
        expect(
          NumberFormatter.truncateToDecimalPlaces(3.14159, 2),
          equals(3.14),
        );
      });

      test('truncates to 0 decimal places', () {
        expect(
          NumberFormatter.truncateToDecimalPlaces(3.9, 0),
          equals(3.0),
        );
      });

      test('handles negative values', () {
        expect(
          NumberFormatter.truncateToDecimalPlaces(-3.14159, 2),
          equals(-3.14),
        );
      });

      test('handles zero', () {
        expect(
          NumberFormatter.truncateToDecimalPlaces(0, 3),
          equals(0.0),
        );
      });

      test('throws on negative fractional digits', () {
        expect(
          () => NumberFormatter.truncateToDecimalPlaces(3.14, -1),
          throwsArgumentError,
        );
      });

      test('handles infinity', () {
        expect(
          NumberFormatter.truncateToDecimalPlaces(double.infinity, 2),
          equals(double.infinity),
        );
      });
    });

    group('roundToDecimalPlaces', () {
      test('rounds up correctly', () {
        expect(
          NumberFormatter.roundToDecimalPlaces(3.145, 2),
          equals(3.15),
        );
      });

      test('rounds down correctly', () {
        expect(
          NumberFormatter.roundToDecimalPlaces(3.144, 2),
          equals(3.14),
        );
      });

      test('rounds to 0 decimal places', () {
        expect(
          NumberFormatter.roundToDecimalPlaces(3.5, 0),
          equals(4.0),
        );
      });

      test('handles zero', () {
        expect(
          NumberFormatter.roundToDecimalPlaces(0, 2),
          equals(0.0),
        );
      });

      test('handles negative values', () {
        expect(
          NumberFormatter.roundToDecimalPlaces(-3.145, 2),
          equals(-3.15),
        );
      });

      test('throws on negative fractional digits', () {
        expect(
          () => NumberFormatter.roundToDecimalPlaces(3.14, -1),
          throwsArgumentError,
        );
      });

      test('handles NaN', () {
        expect(
          NumberFormatter.roundToDecimalPlaces(double.nan, 2).isNaN,
          isTrue,
        );
      });
    });

    group('formatFileSize', () {
      test('formats bytes correctly', () {
        expect(NumberFormatter.formatFileSize(512), equals('512 B'));
      });

      test('formats kilobytes correctly', () {
        expect(NumberFormatter.formatFileSize(1024), equals('1.0 KB'));
      });

      test('formats megabytes correctly', () {
        expect(NumberFormatter.formatFileSize(1024 * 1024), equals('1.0 MB'));
      });

      test('formats gigabytes correctly', () {
        expect(
          NumberFormatter.formatFileSize(1024 * 1024 * 1024),
          equals('1.0 GB'),
        );
      });

      test('formats zero bytes', () {
        expect(NumberFormatter.formatFileSize(0), equals('0 B'));
      });

      test('formats fractional kilobytes', () {
        expect(NumberFormatter.formatFileSize(1536), equals('1.5 KB'));
      });
    });
  });
}
