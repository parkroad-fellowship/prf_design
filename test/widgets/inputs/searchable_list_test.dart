import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

void main() {
  final testEntries = [
    const PRFSearchableListEntry(value: 'apple', label: 'Apple'),
    const PRFSearchableListEntry(value: 'banana', label: 'Banana'),
    const PRFSearchableListEntry(value: 'cherry', label: 'Cherry'),
  ];

  group('PRFSearchableList - Inline Normal Page', () {
    testWidgets('filters entries when query is typed', (tester) async {
      setHandsetSize(tester);

      await tester.pumpWidget(
        buildSubject(
          PRFSearchableList<String>(
            entries: testEntries,
            onSelected: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Focus search field
      await tester.tap(find.byType(TextFormField));
      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsOneWidget);

      // Type search query
      await tester.enterText(find.byType(TextFormField), 'ban');
      await tester.pumpAndSettle();

      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Apple'), findsNothing);
      expect(find.text('Cherry'), findsNothing);
    });

    testWidgets('selects item in single-select mode', (tester) async {
      setHandsetSize(tester);
      String? selectedValue;

      await tester.pumpWidget(
        buildSubject(
          StatefulBuilder(
            builder: (context, setState) {
              return PRFSearchableList<String>(
                entries: testEntries,
                selection: selectedValue,
                onSelected: (val) => setState(() => selectedValue = val),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Focus and tap 'Banana'
      await tester.tap(find.byType(TextFormField));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Banana'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('banana'));
      expect(find.text('Banana'), findsOneWidget); // Shown in selected chip
    });

    testWidgets('supports multi-select with chips', (tester) async {
      setHandsetSize(tester);
      final selectedValues = <String>['apple'];

      await tester.pumpWidget(
        buildSubject(
          StatefulBuilder(
            builder: (context, setState) {
              return PRFSearchableList<String>(
                entries: testEntries,
                selections: selectedValues,
                onSelected: (val) {
                  setState(() {
                    if (val != null) {
                      if (selectedValues.contains(val)) {
                        selectedValues.remove(val);
                      } else {
                        selectedValues.add(val);
                      }
                    }
                  });
                },
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Chip), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget); // Shown in Chip

      // Focus search field to show dropdown list
      await tester.tap(find.byType(TextFormField));
      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsNWidgets(2)); // Chip + list tile

      await tester.tap(find.text('Cherry'));
      await tester.pumpAndSettle();

      expect(selectedValues, containsAll(['apple', 'cherry']));
    });
  });

  group('PRFSearchableList - Modal Bottom Sheet', () {
    testWidgets('opens modal via PRFSearchableList.showModal', (tester) async {
      setHandsetSize(tester);
      String? pickedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    pickedValue = await PRFSearchableList.showModal<String>(
                      context,
                      title: 'Select Fruit',
                      entries: testEntries,
                    );
                  },
                  child: const Text('Open Picker'),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Picker'));
      await tester.pumpAndSettle();

      expect(find.text('Select Fruit'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);

      await tester.tap(find.text('Cherry'));
      await tester.pumpAndSettle();

      expect(pickedValue, equals('cherry'));
    });
  });
}
