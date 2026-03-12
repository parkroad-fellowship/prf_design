import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prf_design/prf_design.dart';

import '../../helpers/button_test_helpers.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('PRFGoogleAuthButton', () {
    group('handset', () {
      testWidgets('renders correctly', (tester) async {
        setHandsetSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFGoogleAuthButton(
              title: 'Sign in with Google',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(PRFGoogleAuthButton), findsOneWidget);
      });

      testWidgets('displays title text', (tester) async {
        setHandsetSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFGoogleAuthButton(
              title: 'Sign in with Google',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Sign in with Google'), findsOneWidget);
      });

      testWidgets(
        'calls onPressed when tapped and not disabled',
        (tester) async {
          setHandsetSize(tester);

          var callCount = 0;
          await tester.pumpWidget(
            buildSubject(
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
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
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
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
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
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
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
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

      testWidgets(
        'displays Google logo SVG when not loading',
        (tester) async {
          setHandsetSize(tester);

          await tester.pumpWidget(
            buildSubject(
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
                disabled: false,
                onPressed: () {},
              ),
            ),
          );
          await tester.pump();

          expect(find.byType(SvgPicture), findsOneWidget);
        },
      );

      testWidgets(
        'hides Google logo SVG when loading',
        (tester) async {
          setHandsetSize(tester);

          await tester.pumpWidget(
            buildSubject(
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
                disabled: false,
                isLoading: true,
                onPressed: () {},
              ),
            ),
          );
          await tester.pump();

          expect(find.byType(SvgPicture), findsNothing);
        },
      );
    });

    group('tablet', () {
      testWidgets('renders correctly', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFGoogleAuthButton(
              title: 'Sign in with Google',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(PRFGoogleAuthButton), findsOneWidget);
      });

      testWidgets('displays title text', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          buildSubject(
            PRFGoogleAuthButton(
              title: 'Sign in with Google',
              disabled: false,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Sign in with Google'), findsOneWidget);
      });

      testWidgets(
        'calls onPressed when tapped and not disabled',
        (tester) async {
          setTabletSize(tester);

          var callCount = 0;
          await tester.pumpWidget(
            buildSubject(
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
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
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
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
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
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
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
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

      testWidgets(
        'displays Google logo SVG when not loading',
        (tester) async {
          setTabletSize(tester);

          await tester.pumpWidget(
            buildSubject(
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
                disabled: false,
                onPressed: () {},
              ),
            ),
          );
          await tester.pump();

          expect(find.byType(SvgPicture), findsOneWidget);
        },
      );

      testWidgets(
        'hides Google logo SVG when loading',
        (tester) async {
          setTabletSize(tester);

          await tester.pumpWidget(
            buildSubject(
              PRFGoogleAuthButton(
                title: 'Sign in with Google',
                disabled: false,
                isLoading: true,
                onPressed: () {},
              ),
            ),
          );
          await tester.pump();

          expect(find.byType(SvgPicture), findsNothing);
        },
      );
    });
  });
}
