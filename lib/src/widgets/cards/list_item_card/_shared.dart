// Shared data and pure builders for PRFListItemCard variants.
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/theme/extensions/theme_context_extensions.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Immutable bundle of the public PRFListItemCard fields, passed to variants.
@immutable
class ListItemCardData {
  const ListItemCardData({
    required this.title,
    required this.icon,
    required this.activeLabel,
    required this.inactiveLabel,
    required this.deleteLabel,
    required this.deleteSemanticLabel,
    this.subtitle,
    this.isActive,
    this.onTap,
    this.onDelete,
    this.animationIndex,
  });

  final String title;
  final IconData icon;
  final String? subtitle;
  final bool? isActive;
  final String activeLabel;
  final String inactiveLabel;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final String deleteLabel;
  final String deleteSemanticLabel;
  final int? animationIndex;

  String? get statusLabel => switch (isActive) {
    null => null,
    true => activeLabel,
    false => inactiveLabel,
  };
}

/// Leading rounded tile holding the row icon.
Widget buildListItemIconTile(
  BuildContext context, {
  required IconData icon,
  required double tileSize,
  required double iconSize,
}) {
  final scheme = Theme.of(context).colorScheme;
  return ExcludeSemantics(
    child: Container(
      width: tileSize,
      height: tileSize,
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: scheme.onPrimary, size: iconSize),
    ),
  );
}

/// Title + optional subtitle column.
Widget buildListItemText(
  BuildContext context, {
  required String title,
  required TextStyle? titleStyle,
  String? subtitle,
  Widget? below,
}) {
  final theme = Theme.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        title,
        style: titleStyle?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      if (subtitle != null) ...[
        const SizedBox(height: PRFSpacingTokens.xs),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
      if (below != null) ...[
        const SizedBox(height: PRFSpacingTokens.xs),
        below,
      ],
    ],
  );
}

/// Active/inactive chip. Colour is carried by the dot and tinted fill; the
/// text uses the surface foreground so it meets AA on both themes.
Widget buildListItemStatusChip(
  BuildContext context, {
  required bool isActive,
  required String label,
}) {
  final scheme = Theme.of(context).colorScheme;
  final status = context.statusColors;
  final background = isActive
      ? status.success.background
      : scheme.surfaceContainerHighest;
  final dot = isActive ? status.success.main : scheme.onSurfaceVariant;
  final textColor = isActive ? scheme.onSurface : scheme.onSurfaceVariant;

  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: PRFSpacingTokens.sm,
      vertical: PRFSpacingTokens.xs,
    ),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: PRFSpacingTokens.sm,
          height: PRFSpacingTokens.sm,
          decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
        ),
        const SizedBox(width: PRFSpacingTokens.xs),
        Flexible(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

/// Labelled delete button with a ≥48dp target and a row-specific
/// screen-reader label.
Widget buildListItemDeleteButton(
  BuildContext context, {
  required VoidCallback onDelete,
  required String label,
  required String semanticLabel,
}) {
  final scheme = Theme.of(context).colorScheme;
  return Semantics(
    button: true,
    label: semanticLabel,
    onTap: onDelete,
    excludeSemantics: true,
    child: Tooltip(
      message: semanticLabel,
      excludeFromSemantics: true,
      child: TextButton.icon(
        onPressed: onDelete,
        style: TextButton.styleFrom(
          foregroundColor: scheme.error,
          minimumSize: const Size(
            PRFSizeTokens.minTouchTarget,
            PRFSizeTokens.minTouchTarget,
          ),
          tapTargetSize: MaterialTapTargetSize.padded,
          padding: const EdgeInsets.symmetric(horizontal: PRFSpacingTokens.sm),
        ),
        icon: const Icon(Icons.delete_outline, size: PRFSizeTokens.iconMd),
        label: Text(label),
      ),
    ),
  );
}

/// Wraps the row in an ink surface, tap semantics, and the optional
/// staggered entrance.
Widget buildListItemSurface(
  BuildContext context, {
  required ListItemCardData data,
  required EdgeInsets padding,
  required Widget child,
}) {
  final scheme = Theme.of(context).colorScheme;
  Widget row = Material(
    color: scheme.surface,
    child: InkWell(
      onTap: data.onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: PRFSizeTokens.minTouchTarget,
        ),
        padding: padding,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
        ),
        child: child,
      ),
    ),
  );

  row = Semantics(container: true, button: data.onTap != null, child: row);

  final index = data.animationIndex;
  final duration = PRFMotionTokens.resolve(context, PRFMotionTokens.enterShort);
  if (index == null || duration == Duration.zero) return row;

  // Cap the stagger so long lists don't make the user wait.
  final delay = PRFMotionTokens.stagger1 * math.min(index, 8);
  return row
      .animate()
      .fadeIn(duration: duration, delay: delay, curve: PRFMotionTokens.entering)
      .slideX(
        begin: 0.05,
        end: 0,
        duration: duration,
        delay: delay,
        curve: PRFMotionTokens.entering,
      );
}
