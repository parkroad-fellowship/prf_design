import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFInfoCard extends StatelessWidget {
  const PRFInfoCard({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: '$label: $value',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: PRFSpacingTokens.lg),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(PRFSpacingTokens.sm),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
              ),
              child: Icon(
                icon,
                size: 20,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: PRFSpacingTokens.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: PRFSpacingTokens.xs),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
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
