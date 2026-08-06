import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/cards/animated_stat_card/_shared.dart';

class AnimatedStatCardHandset extends StatelessWidget {
  const AnimatedStatCardHandset({
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
        padding: const EdgeInsets.all(PRFSpacingTokens.xl),
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
              blurRadius: 20,
              offset: const Offset(0, 10),
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
                size: PRFSizeTokens.iconXxl,
                padding: PRFSpacingTokens.lg,
                delay: delay,
              ),
              const SizedBox(height: PRFSpacingTokens.lg),
            ],
            buildAnimatedValue(
              context,
              theme: theme,
              value: value,
              color: effectiveColor,
              delay: delay + PRFMotionTokens.stagger2,
            ),
            const SizedBox(height: PRFSpacingTokens.sm),
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
