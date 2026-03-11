import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('PRFPrimaryButton', () {
    group('handset', () {
      testWidgets('renders correctly', (tester) async {
        setHandsetSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
              title: 'Test Button',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(PRFPrimaryButton), findsOneWidget);
      });

      testWidgets('displays title text', (tester) async {
        setHandsetSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
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
              PRFPrimaryButton(
                title: 'Button',
                disabled: false,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(find.byType(ElevatedButton));
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
              PRFPrimaryButton(
                title: 'Button',
                disabled: true,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(
            find.byType(ElevatedButton),
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
              PRFPrimaryButton(
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
              PRFPrimaryButton(
                title: 'Button',
                disabled: false,
                isLoading: true,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(
            find.byType(ElevatedButton),
            warnIfMissed: false,
          );
          await tester.pump();

          expect(callCount, equals(0));
        },
      );

      testWidgets('has correct semantics label in normal state', (
        tester,
      ) async {
        setHandsetSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
              title: 'Submit',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        final semantics = tester.getSemantics(
          find
              .ancestor(
                of: find.text('Submit'),
                matching: find.byType(Semantics),
              )
              .first,
        );
        expect(semantics.label, equals('Submit'));
      });

      testWidgets('has correct semantics label when disabled', (tester) async {
        setHandsetSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
              title: 'Submit',
              disabled: true,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        final semantics = tester.getSemantics(
          find
              .ancestor(
                of: find.text('Submit'),
                matching: find.byType(Semantics),
              )
              .first,
        );
        expect(semantics.label, equals('Submit, disabled'));
      });

      testWidgets('has correct semantics label when loading', (tester) async {
        setHandsetSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
              title: 'Submit',
              disabled: false,
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        final semantics = tester.getSemantics(
          find
              .ancestor(
                of: find.text('Submit'),
                matching: find.byType(Semantics),
              )
              .first,
        );
        expect(semantics.label, equals('Submit, loading'));
      });
    });

    group('tablet', () {
      testWidgets('renders correctly', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
              title: 'Test Button',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(PRFPrimaryButton), findsOneWidget);
      });

      testWidgets('displays title text', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
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
              PRFPrimaryButton(
                title: 'Button',
                disabled: false,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(find.byType(ElevatedButton));
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
              PRFPrimaryButton(
                title: 'Button',
                disabled: true,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(
            find.byType(ElevatedButton),
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
              PRFPrimaryButton(
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
              PRFPrimaryButton(
                title: 'Button',
                disabled: false,
                isLoading: true,
                onPressed: () => callCount++,
              ),
            ),
          );
          await tester.pump();

          await tester.tap(
            find.byType(ElevatedButton),
            warnIfMissed: false,
          );
          await tester.pump();

          expect(callCount, equals(0));
        },
      );

      testWidgets('has correct semantics label in normal state', (
        tester,
      ) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
              title: 'Submit',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        final semantics = tester.getSemantics(
          find
              .ancestor(
                of: find.text('Submit'),
                matching: find.byType(Semantics),
              )
              .first,
        );
        expect(semantics.label, equals('Submit'));
      });

      testWidgets('has correct semantics label when disabled', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
              title: 'Submit',
              disabled: true,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        final semantics = tester.getSemantics(
          find
              .ancestor(
                of: find.text('Submit'),
                matching: find.byType(Semantics),
              )
              .first,
        );
        expect(semantics.label, equals('Submit, disabled'));
      });

      testWidgets('has correct semantics label when loading', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFPrimaryButton(
              title: 'Submit',
              disabled: false,
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        final semantics = tester.getSemantics(
          find
              .ancestor(
                of: find.text('Submit'),
                matching: find.byType(Semantics),
              )
              .first,
        );
        expect(semantics.label, equals('Submit, loading'));
      });
    });
  });
}
