import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

void main() {
  group('PRFBottomSheet', () {
    testWidgets('renders title and child content', (tester) async {
      setHandsetSize(tester);

      await tester.pumpWidget(
        buildSubject(
          const PRFBottomSheet(
            title: 'Test Sheet',
            child: Text('Sheet Content'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Sheet'), findsOneWidget);
      expect(find.text('Sheet Content'), findsOneWidget);
    });

    testWidgets('calls onClose when close button is tapped', (tester) async {
      setHandsetSize(tester);
      var closeTapped = false;

      await tester.pumpWidget(
        buildSubject(
          PRFBottomSheet(
            title: 'Close Test',
            onClose: () => closeTapped = true,
            child: const SizedBox.shrink(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(closeTapped, isTrue);
    });

    testWidgets('shows modal sheet via PRFBottomSheet.show', (tester) async {
      setHandsetSize(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    await PRFBottomSheet.show<void>(
                      context,
                      title: 'Modal Sheet',
                      child: const Text('Modal Body'),
                    );
                  },
                  child: const Text('Open Sheet'),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Modal Sheet'), findsOneWidget);
      expect(find.text('Modal Body'), findsOneWidget);
    });
  });
}
