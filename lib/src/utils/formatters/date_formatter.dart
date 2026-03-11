import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

/// Date and time formatting utilities with timezone support.
class DateFormatter {
  // Private constructor to prevent instantiation
  DateFormatter._();

  // Cache for timezone locations to improve performance
  static final Map<String, tz.Location> _timezoneCache = {};

  /// Get timezone location with caching
  static tz.Location _getTimezoneLocation(String timezone) {
    return _timezoneCache.putIfAbsent(timezone, () {
      try {
        return tz.getLocation(timezone);
      } on Object catch (_) {
        // Fallback to UTC if timezone data is missing or timezone is invalid.
        return tz.UTC;
      }
    });
  }

  /// Convert UTC DateTime to timezone-aware DateTime
  static tz.TZDateTime _toTimezone(DateTime dateTime, String timezone) {
    final location = _getTimezoneLocation(timezone);
    final universalTime = dateTime.isUtc ? dateTime : dateTime.toUtc();
    return tz.TZDateTime.from(universalTime, location);
  }

  /// Format DateTime with enhanced error handling
  static String formatDateTime(
    DateTime dateTime,
    String timezone, {
    String? locale,
  }) {
    try {
      final dateTimeInLocation = _toTimezone(dateTime, timezone);
      final formatter = DateFormat('EEE, MMM d, y h:mm a', locale);
      return formatter.format(dateTimeInLocation);
    } on Object catch (_) {
      return dateTime.toString();
    }
  }

  /// Format mission date with enhanced error handling
  static String formatMissionDate(
    DateTime dateTime,
    String timezone, {
    String? locale,
  }) {
    try {
      final dateTimeInLocation = _toTimezone(dateTime, timezone);
      final formatter = locale != null
          ? DateFormat.EEEE(locale).add_yMMMd()
          : DateFormat.EEEE().add_yMMMd();
      return formatter.format(dateTimeInLocation);
    } on Exception catch (_) {
      return DateFormat.yMMMd().format(dateTime);
    }
  }

  /// Format date with enhanced error handling
  static String formatDate(
    DateTime dateTime,
    String timezone, {
    String? locale,
  }) {
    try {
      final dateTimeInLocation = _toTimezone(dateTime, timezone);
      final formatter = locale != null
          ? DateFormat.yMMMMd(locale)
          : DateFormat.yMMMMd();
      return formatter.format(dateTimeInLocation);
    } on Exception catch (_) {
      return DateFormat.yMMMMd().format(dateTime);
    }
  }

  /// Format timestamp with full date and time
  static String timestamp(
    DateTime dateTime,
    String timezone, {
    String? locale,
  }) {
    try {
      final dateTimeInLocation = _toTimezone(dateTime, timezone);
      final dateFormatter = locale != null
          ? DateFormat.yMMMMEEEEd(locale)
          : DateFormat.yMMMMEEEEd();
      final timeFormatter = locale != null
          ? DateFormat.jm(locale)
          : DateFormat.jm();

      return '${dateFormatter.format(dateTimeInLocation)} '
          '${timeFormatter.format(dateTimeInLocation)}';
    } on Exception catch (_) {
      return dateTime.toString();
    }
  }

  /// Format time string with timezone conversion
  static String formatTime(String time, String timezone, {String? locale}) {
    try {
      // More robust time parsing
      final timeRegex = RegExp(r'^(\d{1,2}):(\d{2})(?::(\d{2}))?$');
      final match = timeRegex.firstMatch(time);

      if (match == null) {
        throw ArgumentError('Invalid time format: $time');
      }

      final hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final second = int.tryParse(match.group(3) ?? '0') ?? 0;

      // Create a proper DateTime object
      final dateTimeUtc = DateTime.utc(2012, 2, 27, hour, minute, second);
      final location = _getTimezoneLocation(timezone);
      final dateTimeInLocation = tz.TZDateTime.from(dateTimeUtc, location);

      final formatter = locale != null
          ? DateFormat.jm(locale)
          : DateFormat.jm();
      return formatter.format(dateTimeInLocation);
    } on Object catch (_) {
      return time;
    }
  }

  /// Format time from DateTime with enhanced error handling
  static String formatTimeFromDateTime(
    DateTime dateTime,
    String timezone, {
    String? locale,
  }) {
    try {
      final dateTimeInLocation = _toTimezone(dateTime, timezone);
      final formatter = locale != null
          ? DateFormat.jm(locale)
          : DateFormat.jm();
      return formatter.format(dateTimeInLocation);
    } on Exception catch (_) {
      return DateFormat.jm().format(dateTime);
    }
  }

  /// Get relative time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime dateTime, {String? locale}) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? '1 hour ago'
          : '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 minute ago'
          : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  /// Get month abbreviation from month number (1-12)
  static String getMonthAbbreviation(int month) {
    const months = [
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
    return months[month - 1];
  }

  /// Clear timezone cache (useful for testing or memory management)
  static void clearTimezoneCache() {
    _timezoneCache.clear();
  }
}
