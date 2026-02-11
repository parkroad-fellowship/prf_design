import 'dart:math';

import 'package:intl/intl.dart';

/// Number formatting utilities for currency, decimals, and file sizes.
class NumberFormatter {
  // Private constructor to prevent instantiation
  NumberFormatter._();

  /// Format currency amount
  static String formatCash(
    num amount, {
    String locale = 'en_KE',
    String symbol = '',
    int decimalDigits = 0,
    String? customSymbol,
  }) {
    try {
      final formatter = NumberFormat.currency(
        locale: locale,
        symbol: customSymbol ?? symbol,
        decimalDigits: decimalDigits,
      );
      return formatter.format(amount);
    } on Exception catch (_) {
      return amount.toString();
    }
  }

  /// Truncate to decimal places
  static double truncateToDecimalPlaces(double value, int fractionalDigits) {
    if (fractionalDigits < 0) {
      throw ArgumentError('Fractional digits cannot be negative');
    }
    if (!value.isFinite) return value;

    final multiplier = pow(10, fractionalDigits);
    return (value * multiplier).truncate() / multiplier;
  }

  /// Round to decimal places
  static double roundToDecimalPlaces(double value, int fractionalDigits) {
    if (fractionalDigits < 0) {
      throw ArgumentError('Fractional digits cannot be negative');
    }
    if (!value.isFinite) return value;

    final multiplier = pow(10, fractionalDigits);
    return (value * multiplier).round() / multiplier;
  }

  /// Format file size in human readable format
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
