// Shared chip builder for PRFCategoryChips variants.
import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

Widget buildCategoryChip(
  BuildContext context, {
  required ThemeData theme,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  final selectedColor = theme.colorScheme.primary;
  final selectedTextColor = theme.colorScheme.onPrimary;

  return Semantics(
    button: true,
    label: label,
    selected: isSelected,
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: PRFMotionTokens.resolve(context, PRFMotionTokens.standard),
        curve: PRFMotionTokens.settling,
        padding: const EdgeInsets.symmetric(
          horizontal: PRFSpacingTokens.md,
          vertical: PRFSpacingTokens.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(PRFRadiusTokens.xl),
          border: Border.all(
            color: isSelected
                ? selectedColor.withValues(alpha: PRFOpacities.half)
                : theme.colorScheme.outlineVariant,
            width: 1.5,
          ),
          boxShadow: isSelected ? PRFShadowTokens.raised(selectedColor) : [],
        ),
        child: Center(
          child: Text(
            label,
            maxLines: 1,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? selectedTextColor
                  : theme.colorScheme.onSurfaceVariant,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    ),
  );
}

/// Height of the horizontal chip row. Never below [minHeight], but grows with
/// the system text scale so chip labels are not clipped at large font sizes.
double categoryChipRowHeight(
  BuildContext context, {
  required ThemeData theme,
  required double minHeight,
}) {
  final style = theme.textTheme.labelMedium;
  final fontSize = style?.fontSize ?? 13;
  final lineHeight =
      MediaQuery.textScalerOf(context).scale(fontSize) *
      (style?.height ?? 1.35);
  // Vertical padding on both sides plus the 1.5dp border on both sides.
  final chipHeight = lineHeight + PRFSpacingTokens.sm * 2 + 3;
  return chipHeight > minHeight ? chipHeight : minHeight;
}
