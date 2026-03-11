import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';

class AnimatedStatCard extends StatelessWidget {
  const AnimatedStatCard({
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              effectiveColor.withValues(alpha: 0.15),
              effectiveColor.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
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
              Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: effectiveColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: effectiveColor,
                    ),
                  )
                  .animate(delay: delay)
                  .scale(duration: 600.ms, curve: Curves.elasticOut)
                  .fadeIn(),
              const SizedBox(height: 16),
            ],
            Text(
                  value,
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: effectiveColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 56,
                  ),
                  textAlign: TextAlign.center,
                )
                .animate(delay: delay + 200.ms)
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),
            const SizedBox(height: 8),
            Text(
                  label,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: PRFColors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                )
                .animate(delay: delay + 400.ms)
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }
}
