import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/theme/extensions/prf_status_extension.dart';
import 'package:prf_design/src/widgets/states/snackbar.dart';

/// Returns a minimal [ThemeData] that includes [PRFStatusExtension].
ThemeData _testTheme() => ThemeData(
      extensions: const [PRFStatusExtension.light],
    );

/// Wraps [child] in [MaterialApp] + [Scaffold] so snackbars can be shown.
Widget _buildApp(Widget child) => MaterialApp(
      theme: _testTheme(),
      home: Scaffold(body: child),
    );

void main() {
  group('PRFSnackbar', () {
    testWidgets('error() shows snackbar with error icon and message',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => PRFSnackbar.error(context, 'Error message'),
              child: const Text('show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('show'));
      await tester.pump();

      expect(find.text('Error message'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('success() shows snackbar with success icon and message',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => PRFSnackbar.success(context, 'Success message'),
              child: const Text('show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('show'));
      await tester.pump();

      expect(find.text('Success message'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('info() shows snackbar with info icon and message',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => PRFSnackbar.info(context, 'Info message'),
              child: const Text('show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('show'));
      await tester.pump();

      expect(find.text('Info message'), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('warning() shows snackbar with warning icon and message',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => PRFSnackbar.warning(context, 'Warning message'),
              child: const Text('show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('show'));
      await tester.pump();

      expect(find.text('Warning message'), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);
    });

    testWidgets(
        'error() with onRetry shows Retry action and invokes callback on tap',
        (tester) async {
      var retryCalled = false;

      await tester.pumpWidget(
        _buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => PRFSnackbar.error(
                context,
                'Retry message',
                onRetry: () => retryCalled = true,
              ),
              child: const Text('show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('show'));
      await tester.pump();

      expect(find.text('Retry'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      await tester.pump();

      expect(retryCalled, isTrue);
    });

    testWidgets('error() without onRetry does not show Retry action',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => PRFSnackbar.error(context, 'No retry'),
              child: const Text('show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('show'));
      await tester.pump();

      expect(find.text('Retry'), findsNothing);
    });
  });
}
