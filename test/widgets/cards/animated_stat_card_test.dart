import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/widgets/cards/animated_stat_card.dart';

Widget _buildApp(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('AnimatedStatCard', () {
    testWidgets('renders value and label', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const AnimatedStatCard(value: '42', label: 'Members'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('42'), findsOneWidget);
      expect(find.text('Members'), findsOneWidget);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const AnimatedStatCard(
            value: '10',
            label: 'Events',
            icon: Icons.event,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.event), findsOneWidget);
    });

    testWidgets('does not render icon when not provided', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const AnimatedStatCard(value: '10', label: 'Events'),
        ),
      );
      await tester.pumpAndSettle();

      // No icon widget should be in the tree (no IconData supplied)
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('accepts custom color without error', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const AnimatedStatCard(
            value: '99',
            label: 'Score',
            color: Colors.orange,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('99'), findsOneWidget);
      expect(find.text('Score'), findsOneWidget);
    });

    testWidgets('accepts custom delay without error', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const AnimatedStatCard(
            value: '5',
            label: 'Days',
            delay: Duration(milliseconds: 200),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('5'), findsOneWidget);
    });
  });
}
