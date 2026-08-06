import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/cards/stat_highlight_card/_shared.dart';

class StatHighlightCardTablet extends StatelessWidget {
  const StatHighlightCardTablet({
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
        // tablet: more generous padding and a larger icon
        padding: const EdgeInsets.all(PRFSpacingTokens.xl),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient ?? defaultGradient,
          ),
          borderRadius: BorderRadius.circular(PRFRadiusTokens.xxl),
          boxShadow: [
            BoxShadow(
              color: (gradient?.first ?? theme.colorScheme.primary).withValues(
                alpha: 0.3,
              ),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              buildStatIcon(
                context,
                icon: icon!,
                size: PRFSizeTokens.iconXxl,
                padding: PRFSpacingTokens.lg,
                delay: delay,
              ),
              const SizedBox(width: PRFSpacingTokens.xl),
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
                  const SizedBox(height: PRFSpacingTokens.sm),
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
