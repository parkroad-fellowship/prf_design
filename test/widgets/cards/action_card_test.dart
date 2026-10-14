import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

Widget _dark(Widget child) {
  return MaterialApp(
    theme: PRFTheme.dark(scaleFactor: 1),
    home: Scaffold(body: child),
  );
}

void main() {
  const image = SizedBox(height: 40, width: 40);

  group('PRFActionCard', () {
    for (final setSize in [setHandsetSize, setTabletSize]) {
      testWidgets('exposes button semantics and fires onTap', (tester) async {
        setSize(tester);
        var taps = 0;
        final handle = tester.ensureSemantics();
        await tester.pumpWidget(
          buildSubject(
            PRFActionCard(title: 'Schools', image: image, onTap: () => taps++),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          tester.getSemantics(find.bySemanticsLabel('Schools')),
          matchesSemantics(
            label: 'Schools',
            isButton: true,
            hasTapAction: true,
          ),
        );
        await tester.tap(find.text('Schools'));
        expect(taps, 1);
        handle.dispose();
      });
    }

    testWidgets('uses theme colours, not white, in dark mode', (tester) async {
      setHandsetSize(tester);
      await tester.pumpWidget(
        _dark(PRFActionCard(title: 'Schools', image: image, onTap: () {})),
      );
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(PRFActionCard));
      final theme = Theme.of(context);

      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.backgroundColor, theme.scaffoldBackgroundColor);
      expect(avatar.backgroundColor, isNot(Colors.white));

      final icon = tester.widget<Icon>(find.byIcon(Icons.play_arrow_rounded));
      expect(icon.color, theme.colorScheme.onPrimary);
    });
  });
}
