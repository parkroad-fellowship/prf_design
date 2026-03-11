import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/widgets/cards/stat_highlight_card.dart';

Widget _buildApp(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('StatHighlightCard', () {
    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatHighlightCard(
            title: 'Total Users',
            subtitle: '1,234 active accounts',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Total Users'), findsOneWidget);
      expect(find.text('1,234 active accounts'), findsOneWidget);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatHighlightCard(
            title: 'Revenue',
            subtitle: '\$10,000',
            icon: Icons.attach_money,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.attach_money), findsOneWidget);
    });

    testWidgets('does not render icon container when icon is not provided',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatHighlightCard(
            title: 'Revenue',
            subtitle: '\$10,000',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('renders with custom gradient without error', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatHighlightCard(
            title: 'Growth',
            subtitle: '+15%',
            gradient: [Colors.green, Colors.teal],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Growth'), findsOneWidget);
      expect(find.text('+15%'), findsOneWidget);
    });

    testWidgets('accepts custom delay without error', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatHighlightCard(
            title: 'Delay',
            subtitle: 'Animated',
            delay: Duration(milliseconds: 300),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Delay'), findsOneWidget);
    });

    testWidgets('has Semantics with title and subtitle', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatHighlightCard(
            title: 'Total Users',
            subtitle: '1,234 active accounts',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final semanticsWidgets = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final matchingSemantics = semanticsWidgets.where(
        (s) => s.properties.label == 'Total Users: 1,234 active accounts',
      );
      expect(matchingSemantics, isNotEmpty);
    });
  });
}
