import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

void main() {
  group('PRFButton outlined and text variants', () {
    for (final (variant, material) in [
      (PRFButtonVariant.outlined, OutlinedButton),
      (PRFButtonVariant.text, TextButton),
    ]) {
      testWidgets('$variant renders as $material and taps', (tester) async {
        setHandsetSize(tester);
        var taps = 0;
        await tester.pumpWidget(
          buildSubject(
            PRFButton(
              title: 'Recall',
              variant: variant,
              onPressed: () => taps++,
            ),
          ),
        );

        expect(find.byType(material), findsOneWidget);
        await tester.tap(find.text('Recall'));
        expect(taps, 1);
      });

      testWidgets('$variant meets tap-target and label guidelines', (
        tester,
      ) async {
        setHandsetSize(tester);
        final handle = tester.ensureSemantics();
        await tester.pumpWidget(
          buildSubject(
            PRFButton(title: 'Cancel', variant: variant, onPressed: () {}),
          ),
        );

        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    }

    testWidgets('outlined border uses the primary colour', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(
          PRFButton(
            title: 'Recall',
            variant: PRFButtonVariant.outlined,
            onPressed: () {},
          ),
        ),
      );

      final context = tester.element(find.byType(OutlinedButton));
      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      final side = button.style!.side!.resolve({});
      expect(side!.color, Theme.of(context).colorScheme.primary);
    });
  });

  group('PRFButton icon', () {
    testWidgets('shows the icon before the label', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(
          PRFButton(title: 'Add expense', icon: Icons.add, onPressed: () {}),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      final iconX = tester.getCenter(find.byIcon(Icons.add)).dx;
      final labelX = tester.getCenter(find.text('Add expense')).dx;
      expect(iconX, lessThan(labelX));
    });

    testWidgets('loading replaces the icon with a spinner', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(
          PRFButton(
            title: 'Add expense',
            icon: Icons.add,
            isLoading: true,
            onPressed: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsNothing);
      expect(find.byType(PRFCircularProgressIndicator), findsOneWidget);
    });
  });

  group('PRFButton fullWidth', () {
    testWidgets('compact button hugs its label inside a row', (tester) async {
      setHandsetSize(tester);
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        buildSubject(
          Row(
            children: [
              const Expanded(child: Text('Jane Wanjiku')),
              PRFButton(
                title: 'View',
                variant: PRFButtonVariant.text,
                fullWidth: false,
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      final size = tester.getSize(find.byType(TextButton));
      expect(size.width, lessThan(200));
      expect(size.height, greaterThanOrEqualTo(PRFSizeTokens.minTouchTarget));
      expect(tester.takeException(), isNull);
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });
  });
}
