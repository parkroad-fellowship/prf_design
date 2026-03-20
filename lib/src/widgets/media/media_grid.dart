import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// A masonry (Pinterest-style) grid for displaying media tiles.
///
/// The first tile is an optional "Add Media" card. Remaining tiles
/// are built via [itemBuilder] with staggered entrance animations.
class PRFMediaGrid extends StatelessWidget {
  const PRFMediaGrid({
    required this.itemCount,
    required this.itemBuilder,
    this.onAdd,
    this.addLabel = 'Add Media',
    this.addIcon = Icons.add_a_photo_outlined,
    this.crossAxisCount = 2,
    super.key,
  });

  /// Number of media items (excluding the add tile).
  final int itemCount;

  /// Builds each media tile. Index is 0-based (not offset by the add tile).
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// If provided, a dashed "Add Media" tile is shown as the first item.
  final VoidCallback? onAdd;

  /// Label for the add tile.
  final String addLabel;

  /// Icon for the add tile.
  final IconData addIcon;

  /// Number of columns.
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final totalCount = itemCount + (onAdd != null ? 1 : 0);

    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: PRFSpacingTokens.sm,
      crossAxisSpacing: PRFSpacingTokens.sm,
      itemCount: totalCount,
      itemBuilder: (context, index) {
        if (onAdd != null && index == 0) {
          return _AddMediaTile(
            onTap: onAdd!,
            label: addLabel,
            icon: addIcon,
          );
        }

        final mediaIndex = onAdd != null ? index - 1 : index;
        return itemBuilder(context, mediaIndex)
            .animate(delay: Duration(milliseconds: 70 * index))
            .fadeIn(duration: PRFMotionTokens.enterShort)
            .scale(
              begin: const Offset(0.95, 0.95),
              end: const Offset(1, 1),
              duration: PRFMotionTokens.enterShort,
            );
      },
    );
  }
}

class _AddMediaTile extends StatelessWidget {
  const _AddMediaTile({
    required this.onTap,
    required this.label,
    required this.icon,
  });

  final VoidCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
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
                  child: Icon(icon, size: 32, color: theme.colorScheme.primary),
                ),
                const SizedBox(height: PRFSpacingTokens.md),
                Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: PRFMotionTokens.enterShort)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: PRFMotionTokens.enterShort,
        );
  }
}
