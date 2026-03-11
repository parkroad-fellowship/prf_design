import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

Widget _buildApp(Widget child) => MaterialApp(
  home: Scaffold(body: child),
);

void main() {
  group('PRFCircularProgressIndicator', () {
    testWidgets('renders with default parameters (indeterminate)', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildApp(const PRFCircularProgressIndicator()),
      );

      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(indicator.value, isNull);
      expect(indicator.strokeWidth, 2.0);
    });

    testWidgets('renders with value 0.5 (determinate)', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFCircularProgressIndicator(value: 0.5)),
      );

      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(indicator.value, 0.5);
    });

    testWidgets('renders with custom size', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFCircularProgressIndicator(size: 48)),
      );

      final sizedBox = tester.widget<SizedBox>(
        find
            .ancestor(
              of: find.byType(CircularProgressIndicator),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(sizedBox.width, 48.0);
      expect(sizedBox.height, 48.0);
    });

    testWidgets('renders with custom strokeWidth', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFCircularProgressIndicator(strokeWidth: 4)),
      );

      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(indicator.strokeWidth, 4.0);
    });

    testWidgets('renders with custom color', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFCircularProgressIndicator(color: Colors.red)),
      );

      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      final animation = indicator.valueColor! as AlwaysStoppedAnimation<Color>;
      expect(animation.value, Colors.red);
    });

    testWidgets('has Semantics label "Loading"', (tester) async {
      await tester.pumpWidget(
        _buildApp(const PRFCircularProgressIndicator()),
      );

      expect(
        find.bySemanticsLabel('Loading'),
        findsOneWidget,
      );
    });
  });
}
