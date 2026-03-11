import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/enums/prf_error_severity.dart';
import 'package:prf_design/src/enums/prf_error_type.dart';
import 'package:prf_design/src/enums/prf_failure.dart';

void main() {
  group('PRFFailure', () {
    group('constructor', () {
      test('creates instance with required message', () {
        const failure = PRFFailure(message: 'Something went wrong');
        expect(failure.message, equals('Something went wrong'));
        expect(failure.type, equals(PRFErrorType.unknown));
        expect(failure.severity, equals(PRFErrorSeverity.medium));
        expect(failure.isRecoverable, isTrue);
        expect(failure.statusCode, isNull);
        expect(failure.technicalMessage, isNull);
        expect(failure.stackTrace, isNull);
        expect(failure.context, isEmpty);
      });

      test('creates instance with all fields', () {
        const failure = PRFFailure(
          message: 'Error',
          statusCode: 404,
          type: PRFErrorType.notFound,
          severity: PRFErrorSeverity.high,
          technicalMessage: 'Resource not found',
          isRecoverable: false,
          context: {'key': 'value'},
        );
        expect(failure.statusCode, equals(404));
        expect(failure.type, equals(PRFErrorType.notFound));
        expect(failure.severity, equals(PRFErrorSeverity.high));
        expect(failure.technicalMessage, equals('Resource not found'));
        expect(failure.isRecoverable, isFalse);
        expect(failure.context, equals({'key': 'value'}));
      });

      test('implements Exception', () {
        const failure = PRFFailure(message: 'Error');
        expect(failure, isA<Exception>());
      });
    });

    group('fromStatusCode', () {
      test('maps 400 to validation type', () {
        final failure = PRFFailure.fromStatusCode(400, 'Bad request');
        expect(failure.statusCode, equals(400));
        expect(failure.type, equals(PRFErrorType.validation));
        expect(failure.isRecoverable, isTrue);
      });

      test('maps 401 to authentication type', () {
        final failure = PRFFailure.fromStatusCode(401, 'Unauthorized');
        expect(failure.statusCode, equals(401));
        expect(failure.type, equals(PRFErrorType.authentication));
        expect(failure.severity, equals(PRFErrorSeverity.high));
        expect(failure.isRecoverable, isTrue);
      });

      test('maps 403 to authorization type', () {
        final failure = PRFFailure.fromStatusCode(403, 'Forbidden');
        expect(failure.statusCode, equals(403));
        expect(failure.type, equals(PRFErrorType.authorization));
        expect(failure.severity, equals(PRFErrorSeverity.high));
      });

      test('maps 404 to notFound type', () {
        final failure = PRFFailure.fromStatusCode(404, 'Not found');
        expect(failure.statusCode, equals(404));
        expect(failure.type, equals(PRFErrorType.notFound));
      });

      test('maps 408 to timeout type', () {
        final failure = PRFFailure.fromStatusCode(408, 'Request timeout');
        expect(failure.statusCode, equals(408));
        expect(failure.type, equals(PRFErrorType.timeout));
      });

      test('maps 500 to server type with critical severity', () {
        final failure = PRFFailure.fromStatusCode(500, 'Internal server error');
        expect(failure.statusCode, equals(500));
        expect(failure.type, equals(PRFErrorType.server));
        expect(failure.severity, equals(PRFErrorSeverity.critical));
        expect(failure.isRecoverable, isFalse);
      });

      test('maps 503 to server type', () {
        final failure = PRFFailure.fromStatusCode(503, 'Service unavailable');
        expect(failure.type, equals(PRFErrorType.server));
        expect(failure.isRecoverable, isFalse);
      });

      test('maps unknown status code to unknown type', () {
        final failure = PRFFailure.fromStatusCode(418, "I'm a teapot");
        expect(failure.type, equals(PRFErrorType.unknown));
      });
    });

    group('fromException', () {
      test('returns same PRFFailure when input is PRFFailure', () {
        const original = PRFFailure(message: 'Original error');
        final result = PRFFailure.fromException(original);
        expect(result, same(original));
      });

      test('maps SocketException to noConnection failure', () {
        const socketException = SocketException('Connection refused');
        final failure = PRFFailure.fromException(socketException);
        expect(failure.type, equals(PRFErrorType.network));
        expect(failure.severity, equals(PRFErrorSeverity.high));
      });

      test('maps HttpException to network failure', () {
        const httpException = HttpException('Bad request');
        final failure = PRFFailure.fromException(httpException);
        expect(failure.type, equals(PRFErrorType.network));
        expect(failure.severity, equals(PRFErrorSeverity.high));
        expect(failure.technicalMessage, contains('Bad request'));
      });

      test('maps FormatException to validation failure', () {
        const formatException = FormatException('Invalid JSON');
        final failure = PRFFailure.fromException(formatException);
        expect(failure.type, equals(PRFErrorType.validation));
        expect(failure.technicalMessage, equals('Invalid JSON'));
      });

      test('maps generic exception to unknown failure', () {
        final failure = PRFFailure.fromException(Exception('Unknown error'));
        expect(failure.message, contains('Unknown error'));
      });
    });

    group('noConnection', () {
      test('creates network failure with descriptive message', () {
        final failure = PRFFailure.noConnection();
        expect(failure.type, equals(PRFErrorType.network));
        expect(failure.severity, equals(PRFErrorSeverity.high));
        expect(failure.message, contains('internet'));
      });
    });

    group('timeout', () {
      test('creates timeout failure', () {
        final failure = PRFFailure.timeout();
        expect(failure.type, equals(PRFErrorType.timeout));
        expect(failure.message, contains('timed out'));
      });
    });

    group('authentication', () {
      test('creates authentication failure with default message', () {
        final failure = PRFFailure.authentication();
        expect(failure.statusCode, equals(401));
        expect(failure.type, equals(PRFErrorType.authentication));
        expect(failure.severity, equals(PRFErrorSeverity.high));
        expect(failure.message, contains('Authentication'));
      });

      test('creates authentication failure with custom message', () {
        final failure = PRFFailure.authentication(
          message: 'Your session has expired.',
        );
        expect(failure.message, equals('Your session has expired.'));
        expect(failure.type, equals(PRFErrorType.authentication));
      });
    });

    group('authorization', () {
      test('creates authorization failure with default message', () {
        final failure = PRFFailure.authorization();
        expect(failure.statusCode, equals(403));
        expect(failure.type, equals(PRFErrorType.authorization));
        expect(failure.isRecoverable, isFalse);
        expect(failure.message, contains('permission'));
      });

      test('creates authorization failure with custom message', () {
        final failure = PRFFailure.authorization(
          message: 'Admin access required.',
        );
        expect(failure.message, equals('Admin access required.'));
        expect(failure.type, equals(PRFErrorType.authorization));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated message', () {
        const original = PRFFailure(message: 'Original');
        final copy = original.copyWith(message: 'Updated');
        expect(copy.message, equals('Updated'));
        expect(original.message, equals('Original'));
      });

      test('preserves unmodified fields', () {
        const original = PRFFailure(
          message: 'Error',
          statusCode: 404,
          type: PRFErrorType.notFound,
          severity: PRFErrorSeverity.high,
        );
        final copy = original.copyWith(message: 'Updated error');
        expect(copy.statusCode, equals(404));
        expect(copy.type, equals(PRFErrorType.notFound));
        expect(copy.severity, equals(PRFErrorSeverity.high));
      });

      test('can update multiple fields at once', () {
        const original = PRFFailure(message: 'Error');
        final copy = original.copyWith(
          message: 'New error',
          statusCode: 500,
          type: PRFErrorType.server,
          severity: PRFErrorSeverity.critical,
          isRecoverable: false,
        );
        expect(copy.message, equals('New error'));
        expect(copy.statusCode, equals(500));
        expect(copy.type, equals(PRFErrorType.server));
        expect(copy.severity, equals(PRFErrorSeverity.critical));
        expect(copy.isRecoverable, isFalse);
      });

      test('can update context', () {
        const original = PRFFailure(message: 'Error');
        final copy = original.copyWith(context: {'key': 'value'});
        expect(copy.context, equals({'key': 'value'}));
      });

      test('can update technicalMessage', () {
        const original = PRFFailure(message: 'Error');
        final copy = original.copyWith(technicalMessage: 'Debug info');
        expect(copy.technicalMessage, equals('Debug info'));
      });
    });

    group('toString', () {
      test('includes message in output', () {
        const failure = PRFFailure(message: 'Something failed');
        expect(failure.toString(), contains('Something failed'));
      });

      test('includes status code when present', () {
        const failure = PRFFailure(message: 'Error', statusCode: 404);
        expect(failure.toString(), contains('404'));
      });

      test('includes technical message when present', () {
        const failure = PRFFailure(
          message: 'Error',
          technicalMessage: 'Detailed debug info',
        );
        expect(failure.toString(), contains('Detailed debug info'));
      });

      test('omits status code when not present', () {
        const failure = PRFFailure(message: 'Error');
        expect(failure.toString(), isNot(contains('Status')));
      });
    });
  });
}
