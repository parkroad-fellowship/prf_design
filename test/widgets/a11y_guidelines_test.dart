import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

import '../helpers/button_test_helpers.dart';

Future<void> _expectGuidelines(WidgetTester tester, Widget widget) async {
  final handle = tester.ensureSemantics();
  await tester.pumpWidget(buildSubject(widget));
  await tester.pumpAndSettle();
  await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
  await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  handle.dispose();
}

void main() {
  group('tap target and label guidelines', () {
    for (final setSize in [setHandsetSize, setTabletSize]) {
      testWidgets('PRFButton', (tester) async {
        setSize(tester);
        await _expectGuidelines(
          tester,
          Center(
            child: PRFButton(title: 'Continue', onPressed: () {}),
          ),
        );
      });

      testWidgets('PRFReplyComposer send button', (tester) async {
        setSize(tester);
        final controller = TextEditingController(text: 'Hello');
        addTearDown(controller.dispose);
        await _expectGuidelines(
          tester,
          Align(
            alignment: Alignment.bottomCenter,
            child: PRFReplyComposer(
              controller: controller,
              hintText: 'Reply',
              isComposing: true,
              isLoading: false,
              onSend: () {},
            ),
          ),
        );
        expect(find.byTooltip('Send'), findsOneWidget);
      });

      testWidgets('PRFBottomSheet close button', (tester) async {
        setSize(tester);
        await _expectGuidelines(
          tester,
          PRFBottomSheet(
            title: 'Pick a team',
            onClose: () {},
            child: const SizedBox(height: 100),
          ),
        );
        expect(find.byTooltip('Close'), findsOneWidget);
      });

      testWidgets('PRFAppBar back button', (tester) async {
        setSize(tester);
        await _expectGuidelines(
          tester,
          const PRFAppBar(title: 'Mission details'),
        );
        expect(find.byTooltip('Back'), findsOneWidget);
      });

      testWidgets('PRFTabletHeaderRow back button', (tester) async {
        setSize(tester);
        await _expectGuidelines(
          tester,
          PRFTabletHeaderRow(title: 'Teams', onBack: () {}),
        );
        expect(find.byTooltip('Back'), findsOneWidget);
      });
    }
  });
}
