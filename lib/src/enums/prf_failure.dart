import 'package:flutter/foundation.dart';
import 'package:prf_design/src/enums/prf_error_severity.dart';
import 'package:prf_design/src/enums/prf_error_type.dart';

/// Enhanced Failure class for comprehensive error handling.
///
/// Example usage:
/// ```dart
/// throw PRFFailure(
///   message: 'Failed to fetch user data',
///   statusCode: 404,
///   type: PRFErrorType.notFound,
///   severity: PRFErrorSeverity.medium,
///   technicalMessage: 'GET /api/users/123 returned 404',
/// );
/// ```
@immutable
class PRFFailure implements Exception {
  const PRFFailure({
    required this.message,
    this.statusCode,
    this.type = PRFErrorType.unknown,
    this.severity = PRFErrorSeverity.medium,
    this.technicalMessage,
    this.isRecoverable = true,
    this.stackTrace,
    this.context = const {},
  });

  /// Create a PRFFailure from an HTTP status code.
  factory PRFFailure.fromStatusCode(
    int statusCode,
    String message, [
    StackTrace? stackTrace,
  ]) {
    final type = _typeFromStatusCode(statusCode);
    final severity = _severityFromStatusCode(statusCode);
    final isRecoverable = statusCode < 500;

    return PRFFailure(
      message: message,
      statusCode: statusCode,
      type: type,
      severity: severity,
      isRecoverable: isRecoverable,
      stackTrace: stackTrace,
    );
  }

  /// Create a PRFFailure from a generic exception.
  ///
  /// Detects network-related exceptions (SocketException, HttpException)
  /// by runtime type name to avoid a `dart:io` dependency, keeping this
  /// package compatible with Flutter web.
  factory PRFFailure.fromException(Object error, [StackTrace? stackTrace]) {
    if (error is PRFFailure) {
      return error;
    }

    final typeName = error.runtimeType.toString();

    if (typeName == 'SocketException') {
      return PRFFailure.noConnection(stackTrace: stackTrace);
    }

    if (typeName == 'HttpException') {
      return PRFFailure(
        message: 'Network request failed',
        type: PRFErrorType.network,
        severity: PRFErrorSeverity.high,
        technicalMessage: error.toString(),
        stackTrace: stackTrace,
      );
    }

    if (error is FormatException) {
      return PRFFailure(
        message: 'Invalid data format',
        type: PRFErrorType.validation,
        technicalMessage: error.message,
        stackTrace: stackTrace,
      );
    }

    return PRFFailure(
      message: error.toString(),
      stackTrace: stackTrace,
    );
  }

  /// Create a PRFFailure for no network connection.
  factory PRFFailure.noConnection({StackTrace? stackTrace}) {
    return PRFFailure(
      message: 'No internet connection. Please check your network settings.',
      type: PRFErrorType.network,
      severity: PRFErrorSeverity.high,
      stackTrace: stackTrace,
    );
  }

  /// Create a PRFFailure for timeout.
  factory PRFFailure.timeout({StackTrace? stackTrace}) {
    return PRFFailure(
      message: 'Request timed out. Please try again.',
      type: PRFErrorType.timeout,
      stackTrace: stackTrace,
    );
  }

  /// Create a PRFFailure for authentication errors.
  factory PRFFailure.authentication({
    String message = 'Authentication failed. Please sign in again.',
    StackTrace? stackTrace,
  }) {
    return PRFFailure(
      message: message,
      statusCode: 401,
      type: PRFErrorType.authentication,
      severity: PRFErrorSeverity.high,
      stackTrace: stackTrace,
    );
  }

  /// Create a PRFFailure for authorization errors.
  factory PRFFailure.authorization({
    String message = 'You do not have permission to perform this action.',
    StackTrace? stackTrace,
  }) {
    return PRFFailure(
      message: message,
      statusCode: 403,
      type: PRFErrorType.authorization,
      isRecoverable: false,
      stackTrace: stackTrace,
    );
  }

  /// User-friendly error message suitable for display.
  final String message;

  /// HTTP status code, if applicable.
  final int? statusCode;

  /// Type of error for categorization.
  final PRFErrorType type;

  /// Severity level for logging/alerting.
  final PRFErrorSeverity severity;

  /// Technical details for debugging (not shown to users).
  final String? technicalMessage;

  /// Whether the user can recover from this error (e.g., retry).
  final bool isRecoverable;

  /// Stack trace for debugging.
  final StackTrace? stackTrace;

  /// Additional context data for debugging.
  final Map<String, dynamic> context;

  static PRFErrorType _typeFromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return PRFErrorType.validation;
      case 401:
        return PRFErrorType.authentication;
      case 403:
        return PRFErrorType.authorization;
      case 404:
        return PRFErrorType.notFound;
      case 408:
        return PRFErrorType.timeout;
      case >= 500:
        return PRFErrorType.server;
      default:
        return PRFErrorType.unknown;
    }
  }

  static PRFErrorSeverity _severityFromStatusCode(int statusCode) {
    if (statusCode >= 500) return PRFErrorSeverity.critical;
    if (statusCode == 401 || statusCode == 403) return PRFErrorSeverity.high;
    return PRFErrorSeverity.medium;
  }

  /// Create a copy of this PRFFailure with updated fields.
  PRFFailure copyWith({
    String? message,
    int? statusCode,
    PRFErrorType? type,
    PRFErrorSeverity? severity,
    String? technicalMessage,
    bool? isRecoverable,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return PRFFailure(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      technicalMessage: technicalMessage ?? this.technicalMessage,
      isRecoverable: isRecoverable ?? this.isRecoverable,
      stackTrace: stackTrace ?? this.stackTrace,
      context: context ?? this.context,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PRFFailure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          statusCode == other.statusCode &&
          type == other.type &&
          severity == other.severity &&
          technicalMessage == other.technicalMessage &&
          isRecoverable == other.isRecoverable;

  @override
  int get hashCode => Object.hash(
    message,
    statusCode,
    type,
    severity,
    technicalMessage,
    isRecoverable,
  );

  @override
  String toString() {
    final buffer = StringBuffer('PRFFailure: $message');
    if (statusCode != null) buffer.write(' (Status: $statusCode)');
    if (technicalMessage != null) {
      buffer.write('\nTechnical: $technicalMessage');
    }
    return buffer.toString();
  }
}
