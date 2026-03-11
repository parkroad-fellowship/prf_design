import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/widgets/states/empty_state.dart';

Widget _buildApp(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('PRFEmptyView', () {
    testWidgets('renders label and description', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const PRFEmptyView(
            label: 'Nothing here',
            description: 'No items found.',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('No items found.'), findsOneWidget);
    });

    testWidgets('renders provided icon', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const PRFEmptyView(
            label: 'Empty',
            description: 'No data.',
            icon: Icons.folder_open,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.folder_open), findsOneWidget);
    });

    testWidgets('falls back to default inbox icon when no icon provided',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const PRFEmptyView(
            label: 'Empty',
            description: 'No data.',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    });

    testWidgets('shows action button with actionLabel and fires callback',
        (tester) async {
      var actionCalled = false;

      await tester.pumpWidget(
        _buildApp(
          PRFEmptyView(
            label: 'Empty',
            description: 'No items.',
            actionLabel: 'Add Item',
            onActionPressed: () => actionCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Add Item'), findsOneWidget);
      await tester.tap(find.text('Add Item'));
      await tester.pump();

      expect(actionCalled, isTrue);
    });

    testWidgets('renders custom action widget when provided', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFEmptyView(
            label: 'Empty',
            description: 'No items.',
            action: ElevatedButton(
              onPressed: () {},
              child: const Text('Custom Action'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Custom Action'), findsOneWidget);
    });

    testWidgets('does not show button when actionLabel and action are absent',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const PRFEmptyView(
            label: 'Empty',
            description: 'No items.',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ElevatedButton), findsNothing);
    });
  });
}
