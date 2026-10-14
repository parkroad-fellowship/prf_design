import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/a11y_test_helpers.dart';
import '../../helpers/button_test_helpers.dart';

void main() {
  group('PRFStatPill', () {
    testWidgets('renders value and label on handset', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(const PRFStatPill(label: 'Total', value: 12)),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('12'), findsOneWidget);
      expect(find.textContaining('Total'), findsOneWidget);
    });

    testWidgets('renders icon variant on tablet', (tester) async {
      setTabletSize(tester);
      await tester.pumpWidget(
        buildSubject(
          const PRFStatPill(
            label: 'Unread',
            value: 3,
            icon: Icons.mark_chat_unread_rounded,
            tone: PRFStatPillTone.container,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.mark_chat_unread_rounded), findsOneWidget);
    });

    testWidgets('exposes value + label as one semantics label', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        buildSubject(const PRFStatPill(label: 'Completed', value: 7)),
      );
      expect(find.bySemanticsLabel('7 Completed'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('semanticLabel overrides the default', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        buildSubject(
          const PRFStatPill(
            label: 'Done',
            value: 1,
            semanticLabel: 'One course done',
          ),
        ),
      );
      expect(find.bySemanticsLabel('One course done'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('does not overflow at 2x text scale', (tester) async {
      setHandsetSize(tester);
      await expectNoOverflowAtLargeText(
        tester,
        const Wrap(
          children: [
            PRFStatPill(label: 'Completed courses', value: 120),
            PRFStatPill(
              label: 'Waiting for a reply',
              value: 4,
              icon: Icons.mark_chat_unread_rounded,
              tone: PRFStatPillTone.container,
            ),
          ],
        ),
      );
    });
  });
}
