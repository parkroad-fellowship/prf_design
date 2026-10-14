// Shared state class and chip builder for ReplyStatusView variants.
import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Manages selection state shared between handset and tablet variants.
class ReplyStatusState {
  ReplyStatusState({required bool defaultStatus})
    : _selectedStatus = defaultStatus;

  bool _selectedStatus;
  VoidCallback? _rebuild;

  bool get selectedStatus => _selectedStatus;

  // ignore: use_setters_to_change_properties
  void attach(VoidCallback rebuild) => _rebuild = rebuild;

  void select({required bool status}) {
    _selectedStatus = status;
    _rebuild?.call();
  }

  void dispose() => _rebuild = null;
}

Widget buildStatusChip(
  BuildContext context, {
  required ThemeData theme,
  required String label,
  required bool selected,
  required VoidCallback onTap,
  required double chipHeight,
}) {
  final selectedColor = theme.colorScheme.primary;
  final unselectedColor = theme.colorScheme.surface;
  final selectedTextColor = theme.colorScheme.onPrimary;
  final unselectedTextColor = theme.colorScheme.primary;

  return Semantics(
    button: true,
    label: label,
    selected: selected,
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: PRFMotionTokens.resolve(context, PRFMotionTokens.standard),
        curve: PRFMotionTokens.settling,
        // Min, not fixed: the label grows with the system text scale.
        constraints: BoxConstraints(minHeight: chipHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: PRFSpacingTokens.md,
          vertical: PRFSpacingTokens.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
          border: Border.all(
            color: selected
                ? selectedColor.withValues(alpha: PRFOpacities.half)
                : theme.colorScheme.outline.withValues(
                    alpha: PRFOpacities.glow,
                  ),
            width: 1.1,
          ),
          boxShadow: selected ? PRFShadowTokens.raised(selectedColor) : [],
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
