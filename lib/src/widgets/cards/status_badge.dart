import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Small rounded pill showing a status label on a solid background.
///
/// [color] fills the badge; override [textStyle], [padding], [borderRadius] or
/// [boxShadow] for bespoke styling. The label is exposed to screen readers.
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
