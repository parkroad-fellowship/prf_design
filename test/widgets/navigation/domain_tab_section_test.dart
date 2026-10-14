import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/a11y_test_helpers.dart';
import '../../helpers/button_test_helpers.dart';

Widget _section({
  String? subtitle = 'Explore by status',
  int initialIndex = 0,
  ValueChanged<int>? onTabChanged,
  int tabCount = 2,
}) {
  const labels = ['Active', 'Past', 'Draft'];
  return PRFDomainTabSection(
    title: 'Missions',
    subtitle: subtitle,
    initialIndex: initialIndex,
    onTabChanged: onTabChanged,
    tabs: [for (var i = 0; i < tabCount; i++) Tab(text: labels[i])],
    children: [
      for (var i = 0; i < tabCount; i++)
        Center(child: Text('${labels[i]} body')),
    ],
  );
}

void main() {
  group('PRFDomainTabSection', () {
    testWidgets('legacy constructor (title + subtitle) still renders', (
      tester,
    ) async {
      setHandsetSize(tester);
      await tester.pumpWidget(buildSubject(_section()));
      await tester.pumpAndSettle();
      expect(find.text('Missions'), findsOneWidget);
      expect(find.text('Explore by status'), findsOneWidget);
      expect(find.text('Active body'), findsOneWidget);
    });

    testWidgets('subtitle is optional', (tester) async {
      setTabletSize(tester);
      await tester.pumpWidget(buildSubject(_section(subtitle: null)));
      await tester.pumpAndSettle();
      expect(find.text('Missions'), findsOneWidget);
      expect(find.text('Explore by status'), findsNothing);
    });

    testWidgets('initialIndex selects the starting tab', (tester) async {
      setTabletSize(tester);
      await tester.pumpWidget(buildSubject(_section(initialIndex: 1)));
      await tester.pumpAndSettle();
      expect(find.text('Past body'), findsOneWidget);
    });

    testWidgets('initialIndex is clamped', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(buildSubject(_section(initialIndex: 9)));
      await tester.pumpAndSettle();
      expect(find.text('Past body'), findsOneWidget);
    });

    testWidgets('onTabChanged fires once per settled change (tap)', (
      tester,
    ) async {
      setHandsetSize(tester);
      final changes = <int>[];
      await tester.pumpWidget(
        buildSubject(_section(onTabChanged: changes.add)),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Past'));
      await tester.pumpAndSettle();
      expect(changes, [1]);
      expect(find.text('Past body'), findsOneWidget);
    });

    testWidgets('onTabChanged fires on swipe', (tester) async {
      setHandsetSize(tester);
      final changes = <int>[];
      await tester.pumpWidget(
        buildSubject(_section(onTabChanged: changes.add)),
      );
      await tester.pumpAndSettle();
      await tester.fling(find.text('Active body'), const Offset(-300, 0), 1000);
      await tester.pumpAndSettle();
      expect(changes, [1]);
    });

    testWidgets('survives a change in tab count', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(buildSubject(_section()));
      await tester.pumpAndSettle();
      await tester.pumpWidget(buildSubject(_section(tabCount: 3)));
      await tester.pumpAndSettle();
      expect(find.text('Draft'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('title is a semantics header', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(buildSubject(_section()));
      await tester.pumpAndSettle();
      expect(
        tester.getSemantics(find.text('Missions')).flagsCollection.isHeader,
        isTrue,
      );
      handle.dispose();
    });

    testWidgets('does not overflow at 2x text scale', (tester) async {
      setHandsetSize(tester);
      await expectNoOverflowAtLargeText(tester, _section());
    });
  });
}
