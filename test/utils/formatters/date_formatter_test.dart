import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/utils/formatters/date_formatter.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  setUpAll(tz.initializeTimeZones);

  setUp(DateFormatter.clearTimezoneCache);

  group('DateFormatter', () {
    group('formatDateTime', () {
      test('returns formatted date and time string', () {
        final dateTime = DateTime.utc(2024, 6, 15, 14, 30);
        final result = DateFormatter.formatDateTime(dateTime, 'UTC');
        expect(result, isNotEmpty);
        expect(result, isA<String>());
      });

      test('includes day of week in output', () {
        // June 15, 2024 is a Saturday
        final dateTime = DateTime.utc(2024, 6, 15, 10);
        final result = DateFormatter.formatDateTime(dateTime, 'UTC');
        expect(result, contains('Sat'));
      });

      test('converts to different timezone', () {
        final dateTime = DateTime.utc(2024);
        final utcResult = DateFormatter.formatDateTime(dateTime, 'UTC');
        final nyResult = DateFormatter.formatDateTime(
          dateTime,
          'America/New_York',
        );
        expect(utcResult, isNot(equals(nyResult)));
      });

      test('falls back gracefully for invalid timezone', () {
        final dateTime = DateTime.utc(2024, 6, 15, 14, 30);
        final result = DateFormatter.formatDateTime(
          dateTime,
          'Invalid/Timezone',
        );
        expect(result, isA<String>());
        expect(result, isNotEmpty);
      });

      test('works with non-UTC DateTime input', () {
        final dateTime = DateTime(2024, 6, 15, 14, 30);
        final result = DateFormatter.formatDateTime(dateTime, 'UTC');
        expect(result, isA<String>());
        expect(result, isNotEmpty);
      });
    });

    group('formatDate', () {
      test('returns formatted date string', () {
        final dateTime = DateTime.utc(2024, 3, 15);
        final result = DateFormatter.formatDate(dateTime, 'UTC');
        expect(result, isNotEmpty);
        expect(result, contains('2024'));
      });

      test('includes month name in output', () {
        final dateTime = DateTime.utc(2024, 3, 15);
        final result = DateFormatter.formatDate(dateTime, 'UTC');
        expect(result, contains('March'));
      });

      test('uses timezone when formatting', () {
        final dateTime = DateTime.utc(2024, 1, 1, 0, 30);
        final utcResult = DateFormatter.formatDate(dateTime, 'UTC');
        final nyResult = DateFormatter.formatDate(dateTime, 'America/New_York');
        // 00:30 UTC is still Jan 1 in UTC but Dec 31 in New York
        expect(utcResult, contains('January'));
        expect(nyResult, contains('December'));
      });

      test('works with locale parameter', () {
        final dateTime = DateTime.utc(2024, 6, 15);
        final result = DateFormatter.formatDate(dateTime, 'UTC', locale: 'en');
        expect(result, isNotEmpty);
      });
    });

    group('formatTime', () {
      test('formats a valid time string in UTC', () {
        final result = DateFormatter.formatTime('14:30', 'UTC');
        expect(result, isA<String>());
        expect(result, isNotEmpty);
      });

      test('formats time with seconds', () {
        final result = DateFormatter.formatTime('09:15:30', 'UTC');
        expect(result, isA<String>());
        expect(result, isNotEmpty);
      });

      test('returns original string for invalid time format', () {
        final result = DateFormatter.formatTime('not-a-time', 'UTC');
        expect(result, equals('not-a-time'));
      });

      test('converts time across timezones', () {
        final utcResult = DateFormatter.formatTime('12:00', 'UTC');
        final tokyoResult = DateFormatter.formatTime('12:00', 'Asia/Tokyo');
        expect(utcResult, isNot(equals(tokyoResult)));
      });

      test('handles single-digit hour', () {
        final result = DateFormatter.formatTime('9:05', 'UTC');
        expect(result, isA<String>());
        expect(result, isNotEmpty);
      });
    });

    group('getRelativeTime', () {
      test('returns "Just now" for very recent time', () {
        final now = DateTime.now();
        final result = DateFormatter.getRelativeTime(now);
        expect(result, equals('Just now'));
      });

      test('returns minutes ago for recent time', () {
        final fiveMinutesAgo = DateTime.now().subtract(
          const Duration(minutes: 5),
        );
        final result = DateFormatter.getRelativeTime(fiveMinutesAgo);
        expect(result, equals('5 minutes ago'));
      });

      test('returns "1 minute ago" for exactly one minute', () {
        final oneMinuteAgo = DateTime.now().subtract(
          const Duration(minutes: 1),
        );
        final result = DateFormatter.getRelativeTime(oneMinuteAgo);
        expect(result, equals('1 minute ago'));
      });

      test('returns hours ago for older time', () {
        final threeHoursAgo = DateTime.now().subtract(const Duration(hours: 3));
        final result = DateFormatter.getRelativeTime(threeHoursAgo);
        expect(result, equals('3 hours ago'));
      });

      test('returns "1 hour ago" for exactly one hour', () {
        final oneHourAgo = DateTime.now().subtract(const Duration(hours: 1));
        final result = DateFormatter.getRelativeTime(oneHourAgo);
        expect(result, equals('1 hour ago'));
      });

      test('returns days ago for multi-day difference', () {
        final fiveDaysAgo = DateTime.now().subtract(const Duration(days: 5));
        final result = DateFormatter.getRelativeTime(fiveDaysAgo);
        expect(result, equals('5 days ago'));
      });

      test('returns "1 day ago" for exactly one day', () {
        final oneDayAgo = DateTime.now().subtract(const Duration(days: 1));
        final result = DateFormatter.getRelativeTime(oneDayAgo);
        expect(result, equals('1 day ago'));
      });

      test('returns months ago for multi-month difference', () {
        final twoMonthsAgo = DateTime.now().subtract(const Duration(days: 62));
        final result = DateFormatter.getRelativeTime(twoMonthsAgo);
        expect(result, equals('2 months ago'));
      });

      test('returns years ago for multi-year difference', () {
        final twoYearsAgo = DateTime.now().subtract(const Duration(days: 730));
        final result = DateFormatter.getRelativeTime(twoYearsAgo);
        expect(result, equals('2 years ago'));
      });

      test('returns "1 year ago" for exactly one year', () {
        final oneYearAgo = DateTime.now().subtract(const Duration(days: 366));
        final result = DateFormatter.getRelativeTime(oneYearAgo);
        expect(result, equals('1 year ago'));
      });
    });

    group('getMonthAbbreviation', () {
      test('returns Jan for month 1', () {
        expect(DateFormatter.getMonthAbbreviation(1), equals('Jan'));
      });

      test('returns Feb for month 2', () {
        expect(DateFormatter.getMonthAbbreviation(2), equals('Feb'));
      });

      test('returns Jun for month 6', () {
        expect(DateFormatter.getMonthAbbreviation(6), equals('Jun'));
      });

      test('returns Dec for month 12', () {
        expect(DateFormatter.getMonthAbbreviation(12), equals('Dec'));
      });

      test('returns correct abbreviation for all months', () {
        const expected = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        for (var i = 1; i <= 12; i++) {
          expect(
            DateFormatter.getMonthAbbreviation(i),
            equals(expected[i - 1]),
          );
        }
      });
    });
  });
}
