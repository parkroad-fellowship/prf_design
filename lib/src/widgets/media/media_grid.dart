import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/media/media_grid/_handset.dart';
import 'package:prf_design/src/widgets/media/media_grid/_tablet.dart';

/// A masonry (Pinterest-style) grid for displaying media tiles.
///
/// The first tile is an optional "Add Media" card. Remaining tiles
/// are built via [itemBuilder] with staggered entrance animations.
/// Renders 2 columns on handset and 3 columns on tablet.
class PRFMediaGrid extends StatelessWidget {
  const PRFMediaGrid({
    required this.itemCount,
    required this.itemBuilder,
    this.onAdd,
    this.addLabel = 'Add Media',
    this.addIcon = Icons.add_a_photo_outlined,
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

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFMediaGridHandset(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        onAdd: onAdd,
        addLabel: addLabel,
        addIcon: addIcon,
      ),
      tablet: (_) => PRFMediaGridTablet(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        onAdd: onAdd,
        addLabel: addLabel,
        addIcon: addIcon,
      ),
      builder: (_, _) => PRFMediaGridTablet(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        onAdd: onAdd,
        addLabel: addLabel,
        addIcon: addIcon,
      ),
    );
  }
}
