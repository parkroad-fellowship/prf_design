import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

void main() {
  final entries = [
    const PRFSearchableListEntry(value: 1, label: 'Alpha'),
    const PRFSearchableListEntry(value: 2, label: 'Beta'),
  ];

  for (final setSize in [setHandsetSize, setTabletSize]) {
    testWidgets('clear-selection button has tooltip and 48dp target', (
      tester,
    ) async {
      setSize(tester);
      int? selected = 1;
      await tester.pumpWidget(
        buildSubject(
          StatefulBuilder(
            builder: (context, setState) => PRFSearchableList<int>(
              entries: entries,
              selection: selected,
              onSelected: (v) => setState(() => selected = v),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final clear = find.byTooltip('Clear selection');
      expect(clear, findsOneWidget);
      final size = tester.getSize(
        find.ancestor(of: clear, matching: find.byType(IconButton)),
      );
      expect(size.width, greaterThanOrEqualTo(PRFSizeTokens.minTouchTarget));
      expect(size.height, greaterThanOrEqualTo(PRFSizeTokens.minTouchTarget));

      await tester.tap(clear);
      await tester.pumpAndSettle();
      expect(selected, isNull);
    });
  }

  testWidgets('clear-search button has a localised tooltip', (tester) async {
    setHandsetSize(tester);
    await tester.pumpWidget(
      buildSubject(
        PRFSearchableList<int>(entries: entries, onSelected: (_) {}),
      ),
    );
    await tester.enterText(find.byType(TextFormField), 'Al');
    await tester.pumpAndSettle();
    expect(find.byTooltip('Clear text'), findsOneWidget);
  });

  testWidgets('tablet caps the list width', (tester) async {
    tester.view.physicalSize = const Size(1000, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      buildSubject(
        PRFSearchableList<int>(entries: entries, onSelected: (_) {}),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester.getSize(find.byType(TextFormField)).width,
      lessThanOrEqualTo(680),
    );
  });
}
