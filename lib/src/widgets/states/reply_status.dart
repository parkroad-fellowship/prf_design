import 'package:flutter/material.dart';

/// A widget for selecting reply status (read/unread).
///
/// This is a generic toggle widget that can be used for any binary status.
class ReplyStatusView extends StatefulWidget {
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
  State<ReplyStatusView> createState() => _ReplyStatusViewState();
}

class _ReplyStatusViewState extends State<ReplyStatusView> {
  bool? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.defaultStatus;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final chips = [
      _StatusChip(
        label: widget.unreadLabel.toUpperCase(),
        selected: _selectedStatus == false,
        onTap: () {
          widget.onStatusSelected(status: false);
          setState(() => _selectedStatus = false);
        },
        theme: theme,
      ),
      _StatusChip(
        label: widget.repliedLabel.toUpperCase(),
        selected: _selectedStatus ?? false,
        onTap: () {
          widget.onStatusSelected(status: true);
          setState(() => _selectedStatus = true);
        },
        theme: theme,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 40,
        child: Row(
          children: widget.reversed ? chips.reversed.toList() : chips,
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.theme,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final selectedColor = theme.colorScheme.primary;
    final unselectedColor = theme.colorScheme.surface;
    final selectedTextColor = theme.colorScheme.onPrimary;
    final unselectedTextColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: selected ? selectedColor : unselectedColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? selectedColor.withValues(alpha: 0.5)
                  : theme.colorScheme.outline.withValues(alpha: 0.3),
              width: 1.1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: selectedColor.withValues(alpha: 0.13),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: selected ? selectedTextColor : unselectedTextColor,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
