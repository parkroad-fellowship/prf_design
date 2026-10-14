import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/cards/list_item_card/_shared.dart';

/// Handset layout for PRFListItemCard. Internal — prefer the parent widget.
///
/// The status chip sits under the title so the title keeps most of the
/// narrow row width.
class PRFListItemCardHandset extends StatelessWidget {
  const PRFListItemCardHandset({required this.data, super.key});

  final ListItemCardData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusLabel = data.statusLabel;

    return buildListItemSurface(
      context,
      data: data,
      padding: const EdgeInsets.symmetric(
        horizontal: PRFSpacingTokens.lg,
        vertical: PRFSpacingTokens.sm,
      ),
      child: Row(
        children: [
          buildListItemIconTile(
            context,
            icon: data.icon,
            tileSize: PRFSizeTokens.iconXxxl,
            iconSize: PRFSizeTokens.iconLg,
          ),
          const SizedBox(width: PRFSpacingTokens.md),
          Expanded(
            child: buildListItemText(
              context,
              title: data.title,
              titleStyle: theme.textTheme.titleMedium,
              subtitle: data.subtitle,
              below: statusLabel == null
                  ? null
                  : buildListItemStatusChip(
                      context,
                      isActive: data.isActive!,
                      label: statusLabel,
                    ),
            ),
          ),
          if (data.onDelete != null) ...[
            const SizedBox(width: PRFSpacingTokens.xs),
            buildListItemDeleteButton(
              context,
              onDelete: data.onDelete!,
              label: data.deleteLabel,
              semanticLabel: data.deleteSemanticLabel,
            ),
          ],
        ],
      ),
    );
  }
}
