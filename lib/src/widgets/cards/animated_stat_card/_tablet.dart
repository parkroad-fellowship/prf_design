import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/cards/animated_stat_card/_shared.dart';

class AnimatedStatCardTablet extends StatelessWidget {
  const AnimatedStatCardTablet({
    required this.value,
    required this.label,
    this.icon,
    this.color,
    this.delay = Duration.zero,
    super.key,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color? color;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return Semantics(
      label: '$label: $value',
      child: Container(
        // tablet: larger padding and icon for more visual weight
        padding: const EdgeInsets.all(PRFSpacingTokens.xxxl),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              effectiveColor.withValues(alpha: 0.15),
              effectiveColor.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(PRFRadiusTokens.xxl),
          border: Border.all(
            color: effectiveColor.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: effectiveColor.withValues(alpha: 0.1),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              buildAnimatedIcon(
                context,
                icon: icon!,
                color: effectiveColor,
                size: PRFSizeTokens.iconXxxl,
                padding: PRFSpacingTokens.xl,
                delay: delay,
              ),
              const SizedBox(height: PRFSpacingTokens.xl),
            ],
            buildAnimatedValue(
              context,
              theme: theme,
              value: value,
              color: effectiveColor,
              delay: delay + PRFMotionTokens.stagger2,
            ),
            const SizedBox(height: PRFSpacingTokens.md),
            buildAnimatedLabel(
              context,
              theme: theme,
              label: label,
              onSurfaceColor: theme.colorScheme.onSurfaceVariant,
              delay: delay + PRFMotionTokens.stagger4,
            ),
          ],
        ),
      ),
    );
  }
}
