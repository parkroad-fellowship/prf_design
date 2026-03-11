import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('PRFSecondaryButton', () {
    group('handset', () {
      testWidgets('renders correctly', (tester) async {
        setHandsetSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFSecondaryButton(
              title: 'Test Button',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(PRFSecondaryButton), findsOneWidget);
      });

      testWidgets('displays title text', (tester) async {
        setHandsetSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFSecondaryButton(
              title: 'Click Me',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Click Me'), findsOneWidget);
      });

      testWidgets(
        'calls onPressed when tapped and not disabled',
        (tester) async {
          setHandsetSize(tester);

          var callCount = 0;
          await tester.pumpWidget(
            buildSubject(
              PRFSecondaryButton(
                title: 'Button',
                disabled: false,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(find.byType(OutlinedButton));
          await tester.pump();

          expect(callCount, equals(1));
        },
      );

      testWidgets(
        'does not call onPressed when disabled',
        (tester) async {
          setHandsetSize(tester);

          var callCount = 0;
          await tester.pumpWidget(
            buildSubject(
              PRFSecondaryButton(
                title: 'Button',
                disabled: true,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(
            find.byType(OutlinedButton),
            warnIfMissed: false,
          );
          await tester.pump();

          expect(callCount, equals(0));
        },
      );

      testWidgets(
        'shows CircularProgressIndicator when isLoading',
        (tester) async {
          setHandsetSize(tester);

          await tester.pumpWidget(
            buildSubject(
              PRFSecondaryButton(
                title: 'Button',
                disabled: false,
                isLoading: true,
                onPressed: () {},
              ),
            ),
          );
          await tester.pump();

          expect(
            find.byType(CircularProgressIndicator),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'does not call onPressed when isLoading',
        (tester) async {
          setHandsetSize(tester);

          var callCount = 0;
          await tester.pumpWidget(
            buildSubject(
              PRFSecondaryButton(
                title: 'Button',
                disabled: false,
                isLoading: true,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(
            find.byType(OutlinedButton),
            warnIfMissed: false,
          );
          await tester.pump();

          expect(callCount, equals(0));
        },
      );
    });

    group('tablet', () {
      testWidgets('renders correctly', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFSecondaryButton(
              title: 'Test Button',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(PRFSecondaryButton), findsOneWidget);
      });

      testWidgets('displays title text', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFSecondaryButton(
              title: 'Click Me',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Click Me'), findsOneWidget);
      });

      testWidgets(
        'calls onPressed when tapped and not disabled',
        (tester) async {
          setTabletSize(tester);

          var callCount = 0;
          await tester.pumpWidget(
            buildSubject(
              PRFSecondaryButton(
                title: 'Button',
                disabled: false,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(find.byType(OutlinedButton));
          await tester.pump();

          expect(callCount, equals(1));
        },
      );

      testWidgets(
        'does not call onPressed when disabled',
        (tester) async {
          setTabletSize(tester);

          var callCount = 0;
          await tester.pumpWidget(
            buildSubject(
              PRFSecondaryButton(
                title: 'Button',
                disabled: true,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(
            find.byType(OutlinedButton),
            warnIfMissed: false,
          );
          await tester.pump();

          expect(callCount, equals(0));
        },
      );

      testWidgets(
        'shows CircularProgressIndicator when isLoading',
        (tester) async {
          setTabletSize(tester);

          await tester.pumpWidget(
            buildSubject(
              PRFSecondaryButton(
                title: 'Button',
                disabled: false,
                isLoading: true,
                onPressed: () {},
              ),
            ),
          );
          await tester.pump();

          expect(
            find.byType(CircularProgressIndicator),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'does not call onPressed when isLoading',
        (tester) async {
          setTabletSize(tester);

          var callCount = 0;
          await tester.pumpWidget(
            buildSubject(
              PRFSecondaryButton(
                title: 'Button',
                disabled: false,
                isLoading: true,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(
            find.byType(OutlinedButton),
            warnIfMissed: false,
          );
          await tester.pump();

          expect(callCount, equals(0));
        },
      );
    });
  });
}
