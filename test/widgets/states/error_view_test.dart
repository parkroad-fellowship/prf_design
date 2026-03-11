import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/enums/prf_error_type.dart';
import 'package:prf_design/src/enums/prf_failure.dart';
import 'package:prf_design/src/widgets/states/error_view.dart';

Widget _buildApp(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('PRFErrorView', () {
    testWidgets('renders message text in full layout', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFErrorView(
            failure: PRFFailure(message: 'Something broke'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Something broke'), findsOneWidget);
    });

    testWidgets('shows correct title for network failure type', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFErrorView(
            failure: PRFFailure(
              message: 'No internet',
              type: PRFErrorType.network,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Connection Error'), findsOneWidget);
      expect(find.byIcon(Icons.wifi_off_outlined), findsOneWidget);
    });

    testWidgets('shows correct title for authentication failure type',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFErrorView(
            failure: PRFFailure(
              message: 'Please sign in',
              type: PRFErrorType.authentication,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Authentication Required'), findsOneWidget);
    });

    testWidgets('shows correct title for server failure type', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFErrorView(
            failure: PRFFailure(
              message: 'Internal error',
              type: PRFErrorType.server,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Server Error'), findsOneWidget);
    });

    testWidgets('shows Try Again button when isRecoverable and onRetry set',
        (tester) async {
      var retryCalled = false;

      await tester.pumpWidget(
        _buildApp(
          PRFErrorView(
            failure: PRFFailure(
              message: 'Error',
              isRecoverable: true,
            ),
            onRetry: () => retryCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Try Again'), findsOneWidget);
      await tester.tap(find.text('Try Again'));
      await tester.pump();

      expect(retryCalled, isTrue);
    });

    testWidgets('does not show Try Again button when isRecoverable is false',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFErrorView(
            failure: PRFFailure(
              message: 'Error',
              isRecoverable: false,
            ),
            onRetry: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Try Again'), findsNothing);
    });

    testWidgets('compact layout renders inline row', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFErrorView(
            failure: PRFFailure(message: 'Compact error'),
            compact: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Compact error'), findsOneWidget);
    });

    testWidgets('compact layout shows refresh icon button when onRetry set',
        (tester) async {
      var retryCalled = false;

      await tester.pumpWidget(
        _buildApp(
          PRFErrorView(
            failure: PRFFailure(
              message: 'Compact retry',
              isRecoverable: true,
            ),
            compact: true,
            onRetry: () => retryCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.refresh), findsOneWidget);
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pump();

      expect(retryCalled, isTrue);
    });

    testWidgets('fromMessage factory creates view with correct message',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFErrorView.fromMessage(message: 'Factory message'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Factory message'), findsOneWidget);
    });

    testWidgets('fromFailure factory creates view from PRFFailure',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFErrorView.fromFailure(
            failure: PRFFailure(
              message: 'Failure message',
              type: PRFErrorType.timeout,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Failure message'), findsOneWidget);
      expect(find.text('Request Timeout'), findsOneWidget);
    });
  });
}
