import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/a11y_test_helpers.dart';
import '../../helpers/button_test_helpers.dart';

void main() {
  group('PRFSyncStatusBar', () {
    testWidgets('pending shows count and Upload now on handset', (
      tester,
    ) async {
      setHandsetSize(tester);
      var retries = 0;
      var views = 0;
      await tester.pumpWidget(
        buildSubject(
          PRFSyncStatusBar(
            status: PRFSyncStatus.pending,
            count: 3,
            onRetry: () => retries++,
            onViewDetails: () => views++,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('3 items waiting to upload'), findsOneWidget);
      await tester.tap(find.text('Upload now'));
      await tester.tap(find.text('View'));
      expect(retries, 1);
      expect(views, 1);
    });

    testWidgets('failed shows Try again on tablet', (tester) async {
      setTabletSize(tester);
      await tester.pumpWidget(
        buildSubject(
          PRFSyncStatusBar(
            status: PRFSyncStatus.failed,
            count: 1,
            onRetry: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text("1 item couldn't upload"), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });

    testWidgets('syncing shows progress and hides retry', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(
          PRFSyncStatusBar(
            status: PRFSyncStatus.syncing,
            count: 2,
            progress: 0.5,
            currentItemLabel: 'recording-01.m4a',
            onRetry: () {},
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Uploading 2 items · 50%'), findsOneWidget);
      expect(find.text('recording-01.m4a'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.byType(PRFButton), findsNothing);
    });

    testWidgets('synced has no actions', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(const PRFSyncStatusBar(status: PRFSyncStatus.synced)),
      );
      await tester.pumpAndSettle();
      expect(find.text('Everything is uploaded'), findsOneWidget);
      expect(find.byType(PRFButton), findsNothing);
    });

    testWidgets('labels can be overridden', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(
          PRFSyncStatusBar(
            status: PRFSyncStatus.pending,
            title: 'Rekodi 2 zinasubiri',
            retryLabel: 'Pakia sasa',
            onRetry: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Rekodi 2 zinasubiri'), findsOneWidget);
      expect(find.text('Pakia sasa'), findsOneWidget);
    });

    for (final tablet in [false, true]) {
      final device = tablet ? 'tablet' : 'handset';
      testWidgets('actions are labelled ≥48dp targets ($device)', (
        tester,
      ) async {
        tablet ? setTabletSize(tester) : setHandsetSize(tester);
        final handle = tester.ensureSemantics();
        await tester.pumpWidget(
          buildSubject(
            PRFSyncStatusBar(
              status: PRFSyncStatus.failed,
              count: 4,
              onRetry: () {},
              onViewDetails: () {},
            ),
          ),
        );
        await tester.pumpAndSettle();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });

      testWidgets('does not overflow at 2x text scale ($device)', (
        tester,
      ) async {
        tablet ? setTabletSize(tester) : setHandsetSize(tester);
        await expectNoOverflowAtLargeText(
          tester,
          SingleChildScrollView(
            child: PRFSyncStatusBar(
              status: PRFSyncStatus.failed,
              count: 12,
              onRetry: () {},
              onViewDetails: () {},
            ),
          ),
        );
      });
    }
  });
}
