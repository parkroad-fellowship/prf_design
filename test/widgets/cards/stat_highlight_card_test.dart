import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/widgets/cards/stat_highlight_card/stat_highlight_card.dart';

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
  group('StatHighlightCard', () {
    testWidgets('renders title and subtitle', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const StatHighlightCard(
          title: 'Total Users',
          subtitle: '1,234 active accounts',
        ),
      );

      expect(find.text('Total Users'), findsOneWidget);
      expect(find.text('1,234 active accounts'), findsOneWidget);
      await _disposeTree(tester);
    });

    testWidgets('renders icon when provided', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const StatHighlightCard(
          title: 'Revenue',
          subtitle: r'$10,000',
          icon: Icons.attach_money,
        ),
      );

      expect(find.byIcon(Icons.attach_money), findsOneWidget);
      await _disposeTree(tester);
    });

    testWidgets('does not render icon container when icon is not provided', (
      tester,
    ) async {
      await _pumpAnimatedCard(
        tester,
        const StatHighlightCard(
          title: 'Revenue',
          subtitle: r'$10,000',
        ),
      );

      expect(find.byType(Icon), findsNothing);
      await _disposeTree(tester);
    });

    testWidgets('renders with custom gradient without error', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const StatHighlightCard(
          title: 'Growth',
          subtitle: '+15%',
          gradient: [Colors.green, Colors.teal],
        ),
      );

      expect(find.text('Growth'), findsOneWidget);
      expect(find.text('+15%'), findsOneWidget);
      await _disposeTree(tester);
    });

    testWidgets('accepts custom delay without error', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const StatHighlightCard(
          title: 'Delay',
          subtitle: 'Animated',
          delay: Duration(milliseconds: 300),
        ),
      );

      expect(find.text('Delay'), findsOneWidget);
      await _disposeTree(tester);
    });

    testWidgets('has Semantics with title and subtitle', (tester) async {
      await _pumpAnimatedCard(
        tester,
        const StatHighlightCard(
          title: 'Total Users',
          subtitle: '1,234 active accounts',
        ),
      );

      final semanticsWidgets = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final matchingSemantics = semanticsWidgets.where(
        (s) => s.properties.label == 'Total Users: 1,234 active accounts',
      );
      expect(matchingSemantics, isNotEmpty);
      await _disposeTree(tester);
    });
  });
}
