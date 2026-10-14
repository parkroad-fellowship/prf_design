import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

Widget _scaled(Widget child, double scale) {
  return MediaQuery(
    data: const MediaQueryData(
      size: Size(360, 800),
    ).copyWith(textScaler: TextScaler.linear(scale)),
    child: buildSubject(child),
  );
}

void main() {
  group('PRFButton large text', () {
    for (final setSize in [setHandsetSize, setTabletSize]) {
      testWidgets('grows with 2x text without overflow', (tester) async {
        setSize(tester);
        await tester.pumpWidget(
          _scaled(
            Padding(
              padding: const EdgeInsets.all(PRFSpacingTokens.lg),
              child: PRFButton(
                title: 'Confirm your mission registration',
                onPressed: () {},
              ),
            ),
            2,
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        final height = tester.getSize(find.byType(ElevatedButton)).height;
        expect(height, greaterThanOrEqualTo(PRFButtonTokens.handsetHeight));
        expect(find.text('Confirm your mission registration'), findsOneWidget);
      });
    }

    testWidgets('keeps its token height at default text size', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(PRFButton(title: 'Save', onPressed: () {})),
      );
      await tester.pumpAndSettle();
      expect(
        tester.getSize(find.byType(ElevatedButton)).height,
        PRFButtonTokens.handsetHeight,
      );
    });
  });
}
