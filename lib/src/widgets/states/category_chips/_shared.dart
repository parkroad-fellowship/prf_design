// Shared chip builder for PRFCategoryChips variants.
import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
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
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: PRFSpacingTokens.md,
          vertical: PRFSpacingTokens.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(PRFRadiusTokens.xl),
          border: Border.all(
            color: isSelected
                ? selectedColor.withValues(alpha: 0.5)
                : PRFColors.gray300,
            width: 1.5,
          ),
          boxShadow: isSelected
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
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? selectedTextColor : PRFColors.gray600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    ),
  );
}
