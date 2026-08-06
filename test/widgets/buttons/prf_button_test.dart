import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

void main() {
  for (final variant in PRFButtonVariant.values) {
    final buttonType =
        variant == PRFButtonVariant.secondary ||
            variant == PRFButtonVariant.google
        ? OutlinedButton
        : ElevatedButton;
    final title = variant.name;

    group('PRFButton · $variant', () {
      group('handset', () {
        _variantTests(variant, buttonType, title, setHandsetSize);
      });

      group('tablet', () {
        _variantTests(variant, buttonType, title, setTabletSize);
      });
    });
  }

  group('PRFButton · google logo', () {
    testWidgets('shows Google logo SVG when not loading', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(
          PRFButton(
            title: 'Sign in',
            onPressed: () {},
            variant: PRFButtonVariant.google,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('hides Google logo SVG when loading', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        buildSubject(
          PRFButton(
            title: 'Sign in',
            onPressed: () {},
            variant: PRFButtonVariant.google,
            isLoading: true,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(SvgPicture), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

void _variantTests(
  PRFButtonVariant variant,
  Type buttonType,
  String title,
  void Function(WidgetTester) setSize,
) {
  PRFButton button({bool disabled = false, bool isLoading = false}) {
    return PRFButton(
      title: title,
      onPressed: () {},
      variant: variant,
      disabled: disabled,
      isLoading: isLoading,
    );
  }

  testWidgets('renders correctly', (tester) async {
    setSize(tester);
    await tester.pumpWidget(buildSubject(button()));
    await tester.pump();

    expect(find.byType(PRFButton), findsOneWidget);
    expect(find.byType(buttonType), findsOneWidget);
    expect(find.text(title), findsOneWidget);
  });

  testWidgets('calls onPressed when tapped', (tester) async {
    setSize(tester);
    var callCount = 0;
    await tester.pumpWidget(
      buildSubject(
        PRFButton(
          title: title,
          onPressed: () => callCount++,
          variant: variant,
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byType(buttonType));
    await tester.pump();

    expect(callCount, equals(1));
  });

  testWidgets('does not call onPressed when disabled', (tester) async {
    setSize(tester);
    var callCount = 0;
    await tester.pumpWidget(
      buildSubject(
        PRFButton(
          title: title,
          onPressed: () => callCount++,
          variant: variant,
          disabled: true,
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byType(buttonType), warnIfMissed: false);
    await tester.pump();

    expect(callCount, equals(0));
  });

  testWidgets('shows CircularProgressIndicator when isLoading', (tester) async {
    setSize(tester);
    await tester.pumpWidget(buildSubject(button(isLoading: true)));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('does not call onPressed when isLoading', (tester) async {
    setSize(tester);
    var callCount = 0;
    await tester.pumpWidget(
      buildSubject(
        PRFButton(
          title: title,
          onPressed: () => callCount++,
          variant: variant,
          isLoading: true,
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byType(buttonType), warnIfMissed: false);
    await tester.pump();

    expect(callCount, equals(0));
  });

  testWidgets('has correct semantics label in normal state', (tester) async {
    setSize(tester);
    await tester.pumpWidget(buildSubject(button()));
    await tester.pump();

    final semantics = tester.getSemantics(
      find
          .ancestor(
            of: find.text(title),
            matching: find.byType(Semantics),
          )
          .first,
    );
    expect(semantics.label, equals(title));
  });

  testWidgets('has correct semantics label when disabled', (tester) async {
    setSize(tester);
    await tester.pumpWidget(buildSubject(button(disabled: true)));
    await tester.pump();

    final semantics = tester.getSemantics(
      find
          .ancestor(
            of: find.text(title),
            matching: find.byType(Semantics),
          )
          .first,
    );
    expect(semantics.label, equals('$title, disabled'));
  });

  testWidgets('has correct semantics label when loading', (tester) async {
    setSize(tester);
    await tester.pumpWidget(buildSubject(button(isLoading: true)));
    await tester.pump();

    final semantics = tester.getSemantics(
      find
          .ancestor(
            of: find.text(title),
            matching: find.byType(Semantics),
          )
          .first,
    );
    expect(semantics.label, equals('$title, loading'));
  });
}
