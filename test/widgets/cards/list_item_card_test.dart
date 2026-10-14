import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/a11y_test_helpers.dart';
import '../../helpers/button_test_helpers.dart';

Widget _card({
  bool? isActive = true,
  VoidCallback? onTap,
  VoidCallback? onDelete,
  int? animationIndex,
}) {
  return ListView(
    children: [
      PRFListItemCard(
        title: 'Teacher',
        subtitle: 'Education',
        icon: Icons.work_outlined,
        isActive: isActive,
        onTap: onTap,
        onDelete: onDelete,
        animationIndex: animationIndex,
      ),
    ],
  );
}

void main() {
  group('PRFListItemCard', () {
    testWidgets('renders title, subtitle and status on handset', (
      tester,
    ) async {
      setHandsetSize(tester);
      await tester.pumpWidget(buildSubject(_card(onDelete: () {})));
      await tester.pumpAndSettle();
      expect(find.text('Teacher'), findsOneWidget);
      expect(find.text('Education'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('renders inactive status on tablet', (tester) async {
      setTabletSize(tester);
      await tester.pumpWidget(buildSubject(_card(isActive: false)));
      await tester.pumpAndSettle();
      expect(find.text('Inactive'), findsOneWidget);
      expect(find.text('Delete'), findsNothing);
    });

    testWidgets('hides status chip when isActive is null', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(buildSubject(_card(isActive: null)));
      await tester.pumpAndSettle();
      expect(find.text('Active'), findsNothing);
      expect(find.text('Inactive'), findsNothing);
    });

    testWidgets('localised status labels are used', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(
          const PRFListItemCard(
            title: 'Mwalimu',
            icon: Icons.work_outlined,
            isActive: true,
            activeLabel: 'Hai',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Hai'), findsOneWidget);
    });

    testWidgets('tap and delete call their callbacks separately', (
      tester,
    ) async {
      setHandsetSize(tester);
      var taps = 0;
      var deletes = 0;
      await tester.pumpWidget(
        buildSubject(_card(onTap: () => taps++, onDelete: () => deletes++)),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Teacher'));
      await tester.tap(find.text('Delete'));
      expect(taps, 1);
      expect(deletes, 1);
    });

    testWidgets('delete has a row-specific label and 48dp targets', (
      tester,
    ) async {
      setTabletSize(tester);
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        buildSubject(_card(onTap: () {}, onDelete: () {})),
      );
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('Delete Teacher'), findsOneWidget);
      final size = tester.getSize(find.byType(TextButton));
      expect(size.height, greaterThanOrEqualTo(PRFSizeTokens.minTouchTarget));
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });

    testWidgets('entrance animation settles', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(buildSubject(_card(animationIndex: 3)));
      await tester.pumpAndSettle();
      expect(find.text('Teacher'), findsOneWidget);
    });

    testWidgets('does not overflow at 2x text scale (handset)', (tester) async {
      setHandsetSize(tester);
      await expectNoOverflowAtLargeText(
        tester,
        _card(onTap: () {}, onDelete: () {}),
      );
    });

    testWidgets('does not overflow at 2x text scale (tablet)', (tester) async {
      setTabletSize(tester);
      await expectNoOverflowAtLargeText(
        tester,
        _card(onTap: () {}, onDelete: () {}),
      );
    });
  });
}
