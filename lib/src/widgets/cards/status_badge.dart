import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/extensions/theme_context_extensions.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Small rounded pill showing a status label on a solid background.
///
/// [color] fills the badge. The label colour defaults to the matching status
/// set's `onColor` (or white / deep navy, whichever reads better on [color]),
/// so any `context.statusColors.<status>.main` fill clears WCAG AA. Override
/// [foregroundColor], [textStyle], [padding], [borderRadius] or [boxShadow]
/// for bespoke styling. The label is exposed to screen readers.
///
/// Example:
/// ```dart
/// PRFStatusBadge(
///   label: 'Completed',
///   color: context.statusColors.success.main,
/// )
/// ```
class PRFStatusBadge extends StatelessWidget {
  const PRFStatusBadge({
    required this.label,
    required this.color,
    super.key,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.boxShadow,
    this.foregroundColor,
  });

  /// Status text.
  final String label;

  /// Background colour of the badge.
  final Color color;

  /// Overrides the default horizontal/vertical padding.
  final EdgeInsetsGeometry? padding;

  /// Overrides the default rounded corners.
  final BorderRadius? borderRadius;

  /// Overrides the label text style.
  final TextStyle? textStyle;

  /// Overrides the default soft shadow.
  final List<BoxShadow>? boxShadow;

  /// Overrides the label colour. Defaults to a readable on-colour for [color].
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onColor = foregroundColor ?? context.statusColors.onColorFor(color);

    return Semantics(
      label: label,
      child: Container(
        padding:
            padding ??
            const EdgeInsets.symmetric(
              horizontal: PRFSpacingTokens.sm,
              vertical: PRFSpacingTokens.xs,
            ),
        decoration: BoxDecoration(
          color: color,
          borderRadius:
              borderRadius ?? BorderRadius.circular(PRFRadiusTokens.smd),
          boxShadow:
              boxShadow ??
              [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
        ),
        child: Text(
          label,
          style:
              textStyle ??
              theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: onColor,
              ),
        ),
      ),
    );
  }
}
