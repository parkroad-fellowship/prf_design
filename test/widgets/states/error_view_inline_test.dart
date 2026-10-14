import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/a11y_test_helpers.dart';
import '../../helpers/button_test_helpers.dart';

void main() {
  group('PRFErrorView.inline', () {
    testWidgets('uses plain-language defaults on handset', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(PRFErrorView.inline(onRetry: () {})),
      );
      await tester.pumpAndSettle();
      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Check your connection and try again.'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });

    testWidgets('accepts localised strings on tablet', (tester) async {
      setTabletSize(tester);
      var retries = 0;
      await tester.pumpWidget(
        buildSubject(
          PRFErrorView.inline(
            title: 'Hitilafu',
            message: 'Jaribu tena baadaye.',
            retryLabel: 'Jaribu tena',
            onRetry: () => retries++,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Hitilafu'), findsOneWidget);
      await tester.tap(find.text('Jaribu tena'));
      expect(retries, 1);
    });

    testWidgets('no retry button without onRetry', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(buildSubject(PRFErrorView.inline()));
      await tester.pumpAndSettle();
      expect(find.text('Try again'), findsNothing);
    });

    for (final tablet in [false, true]) {
      testWidgets(
        'retry is a labelled ≥48dp button (${tablet ? 'tablet' : 'handset'})',
        (tester) async {
          tablet ? setTabletSize(tester) : setHandsetSize(tester);
          final handle = tester.ensureSemantics();
          await tester.pumpWidget(
            buildSubject(PRFErrorView.inline(onRetry: () {})),
          );
          await tester.pumpAndSettle();
          final node = tester.getSemantics(find.text('Try again'));
          expect(node.flagsCollection.isButton, isTrue);
          final size = tester.getSize(find.byType(TextButton));
          expect(
            size.height,
            greaterThanOrEqualTo(PRFSizeTokens.minTouchTarget),
          );
          await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
          await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
          handle.dispose();
        },
      );
    }

    testWidgets('title override on the main constructor', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(
          const PRFErrorView(
            failure: PRFFailure(message: 'Could not load'),
            title: 'Missions unavailable',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Missions unavailable'), findsOneWidget);
    });

    testWidgets('full view retry uses custom label', (tester) async {
      setTabletSize(tester);
      await tester.pumpWidget(
        buildSubject(
          PRFErrorView.fromMessage(
            message: 'Could not load',
            retryLabel: 'Reload',
            onRetry: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Reload'), findsOneWidget);
    });

    testWidgets('inline does not overflow at 2x text scale (handset)', (
      tester,
    ) async {
      setHandsetSize(tester);
      await expectNoOverflowAtLargeText(
        tester,
        PRFErrorView.inline(onRetry: () {}),
      );
    });

    testWidgets('inline does not overflow at 2x text scale (tablet)', (
      tester,
    ) async {
      setTabletSize(tester);
      await expectNoOverflowAtLargeText(
        tester,
        PRFErrorView.inline(onRetry: () {}),
      );
    });

    testWidgets('full view does not overflow at 2x text scale', (tester) async {
      setHandsetSize(tester);
      await expectNoOverflowAtLargeText(
        tester,
        PRFErrorView.fromMessage(
          message: 'We could not load your missions right now.',
          onRetry: () {},
        ),
      );
    });
  });
}
