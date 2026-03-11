import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/widgets/states/reply_status.dart';

Widget _buildApp(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('ReplyStatusView', () {
    testWidgets('renders both status chips', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          ReplyStatusView(
            onStatusSelected: ({required status}) {},
            unreadLabel: 'Unread',
            repliedLabel: 'Replied',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('UNREAD'), findsOneWidget);
      expect(find.text('REPLIED'), findsOneWidget);
    });

    testWidgets('calls onStatusSelected with false when unread chip tapped', (
      tester,
    ) async {
      bool? selected;
      await tester.pumpWidget(
        _buildApp(
          ReplyStatusView(
            onStatusSelected: ({required status}) => selected = status,
            unreadLabel: 'Unread',
            repliedLabel: 'Replied',
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('UNREAD'));
      await tester.pump();

      expect(selected, isFalse);
    });

    testWidgets('calls onStatusSelected with true when replied chip tapped', (
      tester,
    ) async {
      bool? selected;
      await tester.pumpWidget(
        _buildApp(
          ReplyStatusView(
            onStatusSelected: ({required status}) => selected = status,
            unreadLabel: 'Unread',
            repliedLabel: 'Replied',
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('REPLIED'));
      await tester.pump();

      expect(selected, isTrue);
    });

    testWidgets('chips have Semantics with button and selected properties', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildApp(
          ReplyStatusView(
            onStatusSelected: ({required status}) {},
            unreadLabel: 'Unread',
            repliedLabel: 'Replied',
          ),
        ),
      );
      await tester.pump();

      final unreadSemantics = tester.getSemantics(
        find
            .ancestor(
              of: find.text('UNREAD'),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(unreadSemantics.flagsCollection.isButton, isTrue);
      expect(unreadSemantics.flagsCollection.isSelected, Tristate.isTrue);

      final repliedSemantics = tester.getSemantics(
        find
            .ancestor(
              of: find.text('REPLIED'),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(repliedSemantics.flagsCollection.isButton, isTrue);
      expect(repliedSemantics.flagsCollection.isSelected, Tristate.isFalse);
    });
  });
}
