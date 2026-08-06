import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/states/reply_status/_shared.dart';

/// Handset layout for ReplyStatusView. Internal — prefer the parent widget.
class PRFReplyStatusHandset extends StatefulWidget {
  const PRFReplyStatusHandset({
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
  State<PRFReplyStatusHandset> createState() => _PRFReplyStatusHandsetState();
}

class _PRFReplyStatusHandsetState extends State<PRFReplyStatusHandset> {
  late final ReplyStatusState _state;

  @override
  void initState() {
    super.initState();
    _state = ReplyStatusState(defaultStatus: widget.defaultStatus);
    _state.attach(() => setState(() {}));
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chips = [
      buildStatusChip(
        context,
        theme: theme,
        label: widget.unreadLabel.toUpperCase(),
        selected: !_state.selectedStatus,
        chipHeight: PRFSizeTokens.minTouchTarget,
        onTap: () {
          widget.onStatusSelected(status: false);
          _state.select(status: false);
        },
      ),
      buildStatusChip(
        context,
        theme: theme,
        label: widget.repliedLabel.toUpperCase(),
        selected: _state.selectedStatus,
        chipHeight: PRFSizeTokens.minTouchTarget,
        onTap: () {
          widget.onStatusSelected(status: true);
          _state.select(status: true);
        },
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PRFSpacingTokens.lg),
      child: SizedBox(
        height: PRFSizeTokens.minTouchTarget,
        child: Row(
          children: [
            for (int i = 0; i < chips.length; i++) ...[
              if (i > 0) const SizedBox(width: PRFSpacingTokens.sm),
              if (widget.reversed) chips[chips.length - 1 - i] else chips[i],
            ],
          ],
        ),
      ),
    );
  }
}
