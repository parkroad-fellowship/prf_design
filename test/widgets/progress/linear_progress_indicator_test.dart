import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/widgets/progress/linear_progress_indicator.dart';

Widget _buildApp(Widget child) => MaterialApp(
      home: Scaffold(body: child),
    );

void main() {
  group('PRFLinearProgressIndicator', () {
    testWidgets('renders with default parameters (indeterminate)',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFLinearProgressIndicator()),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, isNull);
      expect(indicator.minHeight, 4.0);
    });

    testWidgets('renders with value 0.5 (determinate)', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFLinearProgressIndicator(value: 0.5)),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, 0.5);
    });

    testWidgets('renders with custom height', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFLinearProgressIndicator(height: 8)),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.minHeight, 8.0);
    });

    testWidgets('renders with borderRadius', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFLinearProgressIndicator(borderRadius: 4)),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.borderRadius, BorderRadius.circular(4));
    });

    testWidgets('renders with default BorderRadius.zero when no borderRadius',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFLinearProgressIndicator()),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.borderRadius, BorderRadius.zero);
    });

    testWidgets('renders with custom backgroundColor', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const PRFLinearProgressIndicator(backgroundColor: Colors.grey),
        ),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.backgroundColor, Colors.grey);
    });

    testWidgets('renders with custom color', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFLinearProgressIndicator(color: Colors.green)),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      final animation =
          indicator.valueColor as AlwaysStoppedAnimation<Color>;
      expect(animation.value, Colors.green);
    });

    testWidgets('has Semantics label "Loading"', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFLinearProgressIndicator()),
      );

      expect(
        find.bySemanticsLabel('Loading'),
        findsOneWidget,
      );
    });
  });
}
