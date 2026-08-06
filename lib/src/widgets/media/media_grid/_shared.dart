// Shared add-tile builder and animated media item builder
// for PRFMediaGrid variants.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

Widget buildAddMediaTile(
  BuildContext context, {
  required VoidCallback onTap,
  required String label,
  required IconData icon,
}) {
  final theme = Theme.of(context);
  return Semantics(
    button: true,
    label: label,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            width: 2,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.05),
              theme.colorScheme.primary.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(PRFSpacingTokens.lg),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
              ),
              child: Icon(
                icon,
                size: PRFSizeTokens.iconXl,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: PRFSpacingTokens.md),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildAnimatedMediaItem(
  BuildContext context, {
  required Widget child,
  required int index,
}) {
  if (MediaQuery.of(context).disableAnimations) return child;
  return child
      .animate(delay: Duration(milliseconds: 70 * index))
      .fadeIn(duration: PRFMotionTokens.enterShort)
      .scale(
        begin: const Offset(0.95, 0.95),
        end: const Offset(1, 1),
        duration: PRFMotionTokens.enterShort,
      );
}
