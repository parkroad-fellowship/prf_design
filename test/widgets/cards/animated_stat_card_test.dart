import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/widgets/cards/animated_stat_card/animated_stat_card.dart';

Widget _buildApp(Widget child) => MaterialApp(home: Scaffold(body: child));

Future<void> _pumpAnimatedCard(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(_buildApp(child));
  await tester.pump(const Duration(seconds: 2));
}

Future<void> _disposeTree(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
}

void main() {
  group('AnimatedStatCard', () {
    testWidgets('renders value and label', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const AnimatedStatCard(value: '42', label: 'Members'),
      );

      expect(find.text('42'), findsOneWidget);
      expect(find.text('Members'), findsOneWidget);
      await _disposeTree(tester);
    });

    testWidgets('renders icon when provided', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const AnimatedStatCard(
          value: '10',
          label: 'Events',
          icon: Icons.event,
        ),
      );

      expect(find.byIcon(Icons.event), findsOneWidget);
      await _disposeTree(tester);
    });

    testWidgets('does not render icon when not provided', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const AnimatedStatCard(value: '10', label: 'Events'),
      );

      // No icon widget should be in the tree (no IconData supplied)
      expect(find.byType(Icon), findsNothing);
      await _disposeTree(tester);
    });

    testWidgets('accepts custom color without error', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const AnimatedStatCard(
          value: '99',
          label: 'Score',
          color: Colors.orange,
        ),
      );

      expect(find.text('99'), findsOneWidget);
      expect(find.text('Score'), findsOneWidget);
      await _disposeTree(tester);
    });

    testWidgets('accepts custom delay without error', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const AnimatedStatCard(
          value: '5',
          label: 'Days',
          delay: Duration(milliseconds: 200),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      await _disposeTree(tester);
    });

    testWidgets('has Semantics with label and value', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const AnimatedStatCard(value: '42', label: 'Members'),
      );

      final semanticsWidgets = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final matchingSemantics = semanticsWidgets.where(
        (s) => s.properties.label == 'Members: 42',
      );
      expect(matchingSemantics, isNotEmpty);
      await _disposeTree(tester);
    });
  });
}
