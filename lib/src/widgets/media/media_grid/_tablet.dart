import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/media/media_grid/_shared.dart';

/// Tablet layout for PRFMediaGrid. Internal — prefer the parent widget.
class PRFMediaGridTablet extends StatelessWidget {
  const PRFMediaGridTablet({
    required this.itemCount,
    required this.itemBuilder,
    this.onAdd,
    this.addLabel = 'Add Media',
    this.addIcon = Icons.add_a_photo_outlined,
    super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final VoidCallback? onAdd;
  final String addLabel;
  final IconData addIcon;

  @override
  Widget build(BuildContext context) {
    final totalCount = itemCount + (onAdd != null ? 1 : 0);

    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // tablet: 3 columns for more content density
      crossAxisCount: 3,
      mainAxisSpacing: PRFSpacingTokens.md,
      crossAxisSpacing: PRFSpacingTokens.md,
      itemCount: totalCount,
      itemBuilder: (context, index) {
        if (onAdd != null && index == 0) {
          return buildAddMediaTile(
            context,
            onTap: onAdd!,
            label: addLabel,
            icon: addIcon,
          );
        }
        final mediaIndex = onAdd != null ? index - 1 : index;
        return buildAnimatedMediaItem(
          context,
          child: itemBuilder(context, mediaIndex),
          index: index,
        );
      },
    );
  }
}
