import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/cards/stat_highlight_card/_shared.dart';

class StatHighlightCardHandset extends StatelessWidget {
  const StatHighlightCardHandset({
    required this.title,
    required this.subtitle,
    this.icon,
    this.gradient,
    this.delay = Duration.zero,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData? icon;
  final List<Color>? gradient;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultGradient = [
      theme.colorScheme.primary,
      theme.colorScheme.primary.withValues(alpha: 0.7),
    ];

    return Semantics(
      label: '$title: $subtitle',
      child: Container(
        padding: const EdgeInsets.all(PRFSpacingTokens.lgAlt),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient ?? defaultGradient,
          ),
          borderRadius: BorderRadius.circular(PRFRadiusTokens.xl),
          boxShadow: [
            BoxShadow(
              color: (gradient?.first ?? theme.colorScheme.primary).withValues(
                alpha: 0.3,
              ),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              buildStatIcon(
                context,
                icon: icon!,
                size: PRFSizeTokens.iconXl,
                padding: PRFSpacingTokens.md,
                delay: delay,
              ),
              const SizedBox(width: PRFSpacingTokens.lg),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildStatTitle(
                    context,
                    theme: theme,
                    title: title,
                    delay: delay + PRFMotionTokens.stagger2,
                  ),
                  const SizedBox(height: PRFSpacingTokens.xs),
                  buildStatSubtitle(
                    context,
                    theme: theme,
                    subtitle: subtitle,
                    delay: delay + PRFMotionTokens.stagger4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
