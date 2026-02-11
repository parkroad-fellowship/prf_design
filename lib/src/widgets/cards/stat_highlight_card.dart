import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design_system/src/theme/colors/prf_colors.dart';

class StatHighlightCard extends StatelessWidget {
  const StatHighlightCard({
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

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient ?? defaultGradient,
        ),
        borderRadius: BorderRadius.circular(20),
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
            Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PRFColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: PRFColors.white,
                  ),
                )
                .animate(delay: delay)
                .scale(duration: 600.ms, curve: Curves.elasticOut)
                .fadeIn(),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                      title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: PRFColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                    .animate(delay: delay + 200.ms)
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.2, end: 0),
                const SizedBox(height: 4),
                Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: PRFColors.white.withValues(alpha: 0.9),
                      ),
                    )
                    .animate(delay: delay + 400.ms)
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.2, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
