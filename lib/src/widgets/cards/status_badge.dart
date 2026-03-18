import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

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

  final String label;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
    );
  }
}
