import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/utils/formatters/string_formatter.dart';

void main() {
  group('StringFormatter', () {
    group('getUserNameInitials', () {
      test('returns initials for a full name', () {
        expect(StringFormatter.getUserNameInitials('John Doe'), equals('JD'));
      });

      test('returns single initial for a single name', () {
        expect(StringFormatter.getUserNameInitials('John'), equals('J'));
      });

      test('returns U for empty string', () {
        expect(StringFormatter.getUserNameInitials(''), equals('U'));
      });

      test('returns U for whitespace-only string', () {
        expect(StringFormatter.getUserNameInitials('   '), equals('U'));
      });

      test('respects maxInitials parameter', () {
        expect(
          StringFormatter.getUserNameInitials(
            'John Michael Doe',
            maxInitials: 3,
          ),
          equals('JMD'),
        );
      });

      test('limits to maxInitials when name has more words', () {
        expect(
          StringFormatter.getUserNameInitials(
            'John Michael Doe',
            maxInitials: 2,
          ),
          equals('JM'),
        );
      });

      test('returns uppercase initials', () {
        expect(StringFormatter.getUserNameInitials('john doe'), equals('JD'));
      });

      test('handles extra whitespace between words', () {
        expect(
          StringFormatter.getUserNameInitials('John  Doe'),
          equals('JD'),
        );
      });
    });

    group('getFileName', () {
      test('returns file name from a full path', () {
        expect(
          StringFormatter.getFileName('/home/user/documents/file.txt'),
          equals('file.txt'),
        );
      });

      test('returns the string itself when no slash', () {
        expect(StringFormatter.getFileName('file.txt'), equals('file.txt'));
      });

      test('returns empty string for empty input', () {
        expect(StringFormatter.getFileName(''), equals(''));
      });

      test('handles path with trailing slash by returning original path', () {
        expect(
          StringFormatter.getFileName('/home/user/'),
          equals('/home/user/'),
        );
      });

      test('handles file name with multiple dots', () {
        expect(
          StringFormatter.getFileName('/path/to/file.tar.gz'),
          equals('file.tar.gz'),
        );
      });

      test('handles deeply nested path', () {
        expect(
          StringFormatter.getFileName('/a/b/c/d/e/file.dart'),
          equals('file.dart'),
        );
      });
    });

    group('generateRandomString', () {
      test('generates string of specified length', () {
        final result = StringFormatter.generateRandomString(10);
        expect(result.length, equals(10));
      });

      test('generates string with only letters when numbers excluded', () {
        final result = StringFormatter.generateRandomString(
          100,
          includeNumbers: false,
        );
        expect(result, matches(RegExp(r'^[a-zA-Z]+$')));
      });

      test('generates string including numbers by default', () {
        // Run multiple times to ensure numbers appear
        final results = List.generate(
          50,
          (_) => StringFormatter.generateRandomString(20),
        );
        final combined = results.join();
        expect(combined, matches(RegExp(r'[0-9]')));
      });

      test('generates string including symbols when requested', () {
        final results = List.generate(
          50,
          (_) => StringFormatter.generateRandomString(
            20,
            includeSymbols: true,
          ),
        );
        final combined = results.join();
        expect(combined, matches(RegExp(r'[!@#\$%\^&\*]')));
      });

      test('returns empty string for length zero', () {
        expect(StringFormatter.generateRandomString(0), equals(''));
      });

      test('two calls produce different results for long strings', () {
        final result1 = StringFormatter.generateRandomString(20);
        final result2 = StringFormatter.generateRandomString(20);
        // Very unlikely to be equal with 20 chars from 62-char charset
        expect(result1 == result2, isFalse);
      });
    });
  });
}
