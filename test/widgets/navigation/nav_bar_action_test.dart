import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/a11y_test_helpers.dart';
import '../../helpers/button_test_helpers.dart';

void main() {
  group('PRFNavBarAction', () {
    testWidgets('renders label and icon, and taps', (tester) async {
      setHandsetSize(tester);
      var taps = 0;
      await tester.pumpWidget(
        buildSubject(
          Center(
            child: PRFNavBarAction(
              label: 'New',
              icon: Icons.add,
              onPressed: () => taps++,
            ),
          ),
        ),
      );
      expect(find.text('New'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(find.byType(PRFNavBarAction));
      expect(taps, 1);
    });

    testWidgets('is at least 48dp and labelled as a button', (tester) async {
      setTabletSize(tester);
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        buildSubject(
          Center(
            child: PRFNavBarAction(
              label: 'Edit',
              variant: PRFNavBarActionVariant.neutral,
              tooltip: 'Edit this member',
              onPressed: () {},
            ),
          ),
        ),
      );
      final size = tester.getSize(find.byType(InkWell));
      expect(size.height, greaterThanOrEqualTo(PRFSizeTokens.minTouchTarget));
      expect(size.width, greaterThanOrEqualTo(PRFSizeTokens.minTouchTarget));
      final node = tester.getSemantics(find.bySemanticsLabel('Edit'));
      expect(node.flagsCollection.isButton, isTrue);
      expect(find.byTooltip('Edit this member'), findsOneWidget);
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });

    testWidgets('disabled when onPressed is null', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        buildSubject(
          const Center(child: PRFNavBarAction(label: 'New', onPressed: null)),
        ),
      );
      final node = tester.getSemantics(find.bySemanticsLabel('New'));
      expect(node.flagsCollection.isEnabled, Tristate.isFalse);
      handle.dispose();
    });
  });

  group('PRFBrandedNavBar', () {
    PRFBrandedNavBar bar({VoidCallback? onBack}) => PRFBrandedNavBar(
      title: 'Professions',
      onBack: onBack,
      actions: [
        PRFNavBarAction(label: 'New', icon: Icons.add, onPressed: () {}),
      ],
    );

    testWidgets('uses the navigation height token', (tester) async {
      expect(
        bar().preferredSize.height,
        PRFNavigationTokens.brandedNavBarHeight,
      );
    });

    testWidgets('back button is a labelled 48dp button (handset)', (
      tester,
    ) async {
      setHandsetSize(tester);
      final handle = tester.ensureSemantics();
      var backs = 0;
      await tester.pumpWidget(buildSubject(bar(onBack: () => backs++)));
      await tester.pumpAndSettle();
      final node = tester.getSemantics(find.bySemanticsLabel('Back'));
      expect(node.flagsCollection.isButton, isTrue);
      expect(find.byTooltip('Back'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      expect(backs, 1);
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });

    testWidgets('renders title and action on tablet', (tester) async {
      setTabletSize(tester);
      await tester.pumpWidget(buildSubject(bar()));
      await tester.pumpAndSettle();
      expect(find.text('Professions'), findsOneWidget);
      expect(find.text('New'), findsOneWidget);
    });

    testWidgets('does not overflow horizontally at 2x text scale', (
      tester,
    ) async {
      setHandsetSize(tester);
      await expectNoOverflowAtLargeText(
        tester,
        Column(
          children: [
            PRFBrandedNavBar(
              title: 'Professions',
              actions: [
                PRFNavBarAction(
                  label: 'Add new',
                  icon: Icons.add,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      );
    });
  });
}
