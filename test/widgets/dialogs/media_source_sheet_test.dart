import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/a11y_test_helpers.dart';
import '../../helpers/button_test_helpers.dart';

void main() {
  group('showPRFMediaSourceSheet', () {
    testWidgets('returns camera on handset', (tester) async {
      setHandsetSize(tester);
      late BuildContext ctx;
      await tester.pumpWidget(
        buildSubject(
          Builder(
            builder: (context) {
              ctx = context;
              return const SizedBox.expand();
            },
          ),
        ),
      );
      final result = showPRFMediaSourceSheet(ctx);
      await tester.pumpAndSettle();
      expect(find.text('Choose a source'), findsOneWidget);
      expect(find.text('Camera'), findsOneWidget);
      expect(find.text('Gallery'), findsOneWidget);
      expect(find.text('Files'), findsNothing);
      await tester.tap(find.text('Camera'));
      await tester.pumpAndSettle();
      expect(await result, PRFMediaSource.camera);
    });

    testWidgets('returns file on tablet with all sources', (tester) async {
      setTabletSize(tester);
      late BuildContext ctx;
      await tester.pumpWidget(
        buildSubject(
          Builder(
            builder: (context) {
              ctx = context;
              return const SizedBox.expand();
            },
          ),
        ),
      );
      final result = showPRFMediaSourceSheet(
        ctx,
        sources: PRFMediaSource.values,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Files'));
      await tester.pumpAndSettle();
      expect(await result, PRFMediaSource.file);
    });

    testWidgets('uses localised labels', (tester) async {
      setHandsetSize(tester);
      late BuildContext ctx;
      await tester.pumpWidget(
        buildSubject(
          Builder(
            builder: (context) {
              ctx = context;
              return const SizedBox.expand();
            },
          ),
        ),
      );
      unawaited(
        showPRFMediaSourceSheet(
          ctx,
          labels: const PRFMediaSourceLabels(
            title: 'Chagua',
            camera: 'Kamera',
            cameraDescription: 'Rekodi video',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Chagua'), findsOneWidget);
      expect(find.text('Kamera'), findsOneWidget);
      expect(find.text('Rekodi video'), findsOneWidget);
    });
  });

  group('PRFMediaSourceSheet', () {
    for (final tablet in [false, true]) {
      testWidgets(
        'options are labelled ≥48dp buttons (${tablet ? 'tablet' : 'handset'})',
        (tester) async {
          tablet ? setTabletSize(tester) : setHandsetSize(tester);
          final handle = tester.ensureSemantics();
          PRFMediaSource? picked;
          await tester.pumpWidget(
            buildSubject(PRFMediaSourceSheet(onSelected: (s) => picked = s)),
          );
          await tester.pumpAndSettle();
          final node = tester.getSemantics(
            find.bySemanticsLabel('Gallery. Choose from your photos'),
          );
          expect(node.flagsCollection.isButton, isTrue);
          await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
          await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
          await tester.tap(find.text('Gallery'));
          expect(picked, PRFMediaSource.gallery);
          handle.dispose();
        },
      );

      testWidgets(
        'does not overflow at 2x text scale (${tablet ? 'tablet' : 'handset'})',
        (tester) async {
          tablet ? setTabletSize(tester) : setHandsetSize(tester);
          await expectNoOverflowAtLargeText(
            tester,
            PRFMediaSourceSheet(
              sources: PRFMediaSource.values,
              onSelected: (_) {},
            ),
          );
        },
      );
    }
  });
}
