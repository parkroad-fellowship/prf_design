import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/states/reply_status/_handset.dart';
import 'package:prf_design/src/widgets/states/reply_status/_tablet.dart';

/// A widget for selecting reply status (read/unread).
///
/// Renders a toggle with [unreadLabel] and [repliedLabel] options. Use
/// [reversed] to flip their order, and [defaultStatus] for the initially
/// selected value.
///
/// Example:
/// ```dart
/// ReplyStatusView(
///   onStatusSelected: ({required bool status}) =>
///       setState(() => _isReplied = status),
///   unreadLabel: 'Unread',
///   repliedLabel: 'Replied',
/// )
/// ```
class ReplyStatusView extends StatelessWidget {
  const ReplyStatusView({
    required this.onStatusSelected,
    required this.unreadLabel,
    required this.repliedLabel,
    this.reversed = false,
    this.defaultStatus = false,
    super.key,
  });

  /// Invoked when a status is picked; `true` means "replied".
  final void Function({required bool status}) onStatusSelected;

  /// Label for the "unread" option.
  final String unreadLabel;

  /// Label for the "replied" option.
  final String repliedLabel;

  /// When true the replied option is rendered first.
  final bool reversed;

  /// The status selected when the view first renders.
  final bool defaultStatus;

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFReplyStatusHandset(
        onStatusSelected: onStatusSelected,
        unreadLabel: unreadLabel,
        repliedLabel: repliedLabel,
        reversed: reversed,
        defaultStatus: defaultStatus,
      ),
      tablet: (_) => PRFReplyStatusTablet(
        onStatusSelected: onStatusSelected,
        unreadLabel: unreadLabel,
        repliedLabel: repliedLabel,
        reversed: reversed,
        defaultStatus: defaultStatus,
      ),
      builder: (_, _) => PRFReplyStatusTablet(
        onStatusSelected: onStatusSelected,
        unreadLabel: unreadLabel,
        repliedLabel: repliedLabel,
        reversed: reversed,
        defaultStatus: defaultStatus,
      ),
    );
  }
}
