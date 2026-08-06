import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/states/reply_status/_handset.dart';
import 'package:prf_design/src/widgets/states/reply_status/_tablet.dart';

/// A widget for selecting reply status (read/unread).
class ReplyStatusView extends StatelessWidget {
  const ReplyStatusView({
    required this.onStatusSelected,
    required this.unreadLabel,
    required this.repliedLabel,
    this.reversed = false,
    this.defaultStatus = false,
    super.key,
  });

  final void Function({required bool status}) onStatusSelected;
  final String unreadLabel;
  final String repliedLabel;
  final bool reversed;
  final bool defaultStatus;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFReplyStatusTablet(
        onStatusSelected: onStatusSelected,
        unreadLabel: unreadLabel,
        repliedLabel: repliedLabel,
        reversed: reversed,
        defaultStatus: defaultStatus,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFReplyStatusHandset(
          onStatusSelected: onStatusSelected,
          unreadLabel: unreadLabel,
          repliedLabel: repliedLabel,
          reversed: reversed,
          defaultStatus: defaultStatus,
        ),
        tablet: (_, _) => PRFReplyStatusTablet(
          onStatusSelected: onStatusSelected,
          unreadLabel: unreadLabel,
          repliedLabel: repliedLabel,
          reversed: reversed,
          defaultStatus: defaultStatus,
        ),
      ),
    );
  }
}
