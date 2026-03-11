import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/widgets/states/category_chips.dart';

Widget _buildApp(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('PRFCategoryChips', () {
    const categories = ['Sports', 'Music', 'Art'];

    testWidgets('renders a chip for each category plus All chip by default',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFCategoryChips<String>(
            categories: categories,
            onCategorySelected: (_) {},
            labelBuilder: (c) => c,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // "ALL" chip + 3 category chips
      expect(find.text('ALL'), findsOneWidget);
      expect(find.text('SPORTS'), findsOneWidget);
      expect(find.text('MUSIC'), findsOneWidget);
      expect(find.text('ART'), findsOneWidget);
    });

    testWidgets('does not show All chip when showAllOption is false',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFCategoryChips<String>(
            categories: categories,
            onCategorySelected: (_) {},
            labelBuilder: (c) => c,
            showAllOption: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('ALL'), findsNothing);
    });

    testWidgets('fires onCategorySelected with null when All chip is tapped',
        (tester) async {
      String? selected = 'Sports';

      await tester.pumpWidget(
        _buildApp(
          StatefulBuilder(
            builder: (context, setState) => PRFCategoryChips<String>(
              categories: categories,
              selectedCategory: selected,
              onCategorySelected: (c) => setState(() => selected = c),
              labelBuilder: (c) => c,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('ALL'));
      await tester.pump();

      expect(selected, isNull);
    });

    testWidgets('fires onCategorySelected with correct category on tap',
        (tester) async {
      String? selected;

      await tester.pumpWidget(
        _buildApp(
          StatefulBuilder(
            builder: (context, setState) => PRFCategoryChips<String>(
              categories: categories,
              selectedCategory: selected,
              onCategorySelected: (c) => setState(() => selected = c),
              labelBuilder: (c) => c,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('MUSIC'));
      await tester.pump();

      expect(selected, equals('Music'));
    });

    testWidgets('shows progress indicator when isLoading is true',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFCategoryChips<String>(
            categories: categories,
            onCategorySelected: (_) {},
            labelBuilder: (c) => c,
            isLoading: true,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.text('ALL'), findsNothing);
    });

    testWidgets('renders empty when categories is empty and showAllOption false',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          PRFCategoryChips<String>(
            categories: const [],
            onCategorySelected: (_) {},
            labelBuilder: (c) => c,
            showAllOption: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsNothing);
    });
  });
}
