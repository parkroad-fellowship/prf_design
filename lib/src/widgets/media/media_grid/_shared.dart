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
            color: theme.colorScheme.primary.withValues(
              alpha: PRFOpacities.glow,
            ),
            width: 2,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withValues(alpha: PRFOpacities.faint),
              theme.colorScheme.primary.withValues(alpha: PRFOpacities.subtle),
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
                color: theme.colorScheme.primary.withValues(
                  alpha: PRFOpacities.subtle,
                ),
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

/// Items past this index share the last stagger slot (total cap 400ms).
const int _maxStaggeredItems = 8;

Widget buildAnimatedMediaItem(
  BuildContext context, {
  required Widget child,
  required int index,
}) {
  if (MediaQuery.of(context).disableAnimations) return child;
  // Cap the stagger so item 40 does not wait seconds to appear: only the
  // first [_maxStaggeredItems] items cascade, the rest arrive together.
  final step = index < _maxStaggeredItems ? index : _maxStaggeredItems;
  final enter = PRFMotionTokens.resolve(context, PRFMotionTokens.enterShort);
  return child
      .animate(
        delay: PRFMotionTokens.resolve(
          context,
          PRFMotionTokens.stagger1 * step,
        ),
      )
      .fadeIn(duration: enter, curve: PRFMotionTokens.entering)
      .scale(
        begin: const Offset(0.95, 0.95),
        end: const Offset(1, 1),
        duration: enter,
        curve: PRFMotionTokens.entering,
      );
}
