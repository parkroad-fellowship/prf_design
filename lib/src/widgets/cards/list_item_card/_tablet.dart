import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/cards/list_item_card/_shared.dart';

/// Tablet layout for PRFListItemCard. Internal — prefer the parent widget.
///
/// Wider rows place the status chip inline before the delete button.
class PRFListItemCardTablet extends StatelessWidget {
  const PRFListItemCardTablet({required this.data, super.key});

  final ListItemCardData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusLabel = data.statusLabel;

    return buildListItemSurface(
      context,
      data: data,
      padding: const EdgeInsets.symmetric(
        horizontal: PRFSpacingTokens.xl,
        vertical: PRFSpacingTokens.md,
      ),
      child: Row(
        children: [
          buildListItemIconTile(
            context,
            icon: data.icon,
            tileSize: PRFSizeTokens.iconHero,
            iconSize: PRFSizeTokens.iconXl,
          ),
          const SizedBox(width: PRFSpacingTokens.lg),
          Expanded(
            child: buildListItemText(
              context,
              title: data.title,
              titleStyle: theme.textTheme.titleLarge,
              subtitle: data.subtitle,
            ),
          ),
          if (statusLabel != null) ...[
            const SizedBox(width: PRFSpacingTokens.md),
            Flexible(
              child: buildListItemStatusChip(
                context,
                isActive: data.isActive!,
                label: statusLabel,
              ),
            ),
          ],
          if (data.onDelete != null) ...[
            const SizedBox(width: PRFSpacingTokens.sm),
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
