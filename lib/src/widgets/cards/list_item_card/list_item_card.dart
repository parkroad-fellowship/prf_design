import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/cards/list_item_card/_handset.dart';
import 'package:prf_design/src/widgets/cards/list_item_card/_shared.dart';
import 'package:prf_design/src/widgets/cards/list_item_card/_tablet.dart';

/// A row for simple lookup lists (professions, churches, gifts, …).
///
/// Shows an icon tile, a [title], an optional [subtitle], an optional
/// active/inactive status chip, and an optional labelled delete button. The
/// whole row is tappable when [onTap] is set.
///
/// Status chips use `context.statusColors` with text in the surface
/// foreground colour, so they stay readable (WCAG AA) in light and dark
/// themes. Pass [activeLabel] / [inactiveLabel] to localise them.
///
/// The delete button shows an icon *and* the word [deleteLabel] so its
/// purpose is clear without guessing; screen readers hear
/// "[deleteLabel] [title]" so each row's button is distinguishable.
///
/// Example:
/// ```dart
/// PRFListItemCard(
///   title: profession.name,
///   icon: Icons.work_outlined,
///   isActive: profession.isActive == PRFActiveStatus.active,
///   onTap: () => _showForm(context, profession),
///   onDelete: () => _confirmDelete(profession),
///   animationIndex: index,
/// )
/// ```
class PRFListItemCard extends StatelessWidget {
  const PRFListItemCard({
    required this.title,
    required this.icon,
    this.subtitle,
    this.isActive,
    this.activeLabel = 'Active',
    this.inactiveLabel = 'Inactive',
    this.onTap,
    this.onDelete,
    this.deleteLabel = 'Delete',
    this.deleteSemanticLabel,
    this.animationIndex,
    super.key,
  });

  /// Primary text, e.g. the record's name.
  final String title;

  /// Icon shown in the leading tile.
  final IconData icon;

  /// Optional secondary line under the title.
  final String? subtitle;

  /// Active/inactive status. When null no status chip is shown.
  final bool? isActive;

  /// Chip text when [isActive] is true. Defaults to "Active".
  final String activeLabel;

  /// Chip text when [isActive] is false. Defaults to "Inactive".
  final String inactiveLabel;

  /// Invoked when the row is tapped. When null the row is not interactive.
  final VoidCallback? onTap;

  /// Invoked when the delete button is tapped. When null no delete button is
  /// shown.
  final VoidCallback? onDelete;

  /// Visible delete button text. Defaults to "Delete".
  final String deleteLabel;

  /// Screen-reader and tooltip text for the delete button. Defaults to
  /// "[deleteLabel] [title]".
  final String? deleteSemanticLabel;

  /// Position in the list, used to stagger the entrance animation. When null
  /// the row appears without animation. Ignored under reduced motion.
  final int? animationIndex;

  @override
  Widget build(BuildContext context) {
    final data = ListItemCardData(
      title: title,
      icon: icon,
      subtitle: subtitle,
      isActive: isActive,
      activeLabel: activeLabel,
      inactiveLabel: inactiveLabel,
      onTap: onTap,
      onDelete: onDelete,
      deleteLabel: deleteLabel,
      deleteSemanticLabel: deleteSemanticLabel ?? '$deleteLabel $title',
      animationIndex: animationIndex,
    );
    return PRFAdaptive(
      handset: (_) => PRFListItemCardHandset(data: data),
      tablet: (_) => PRFListItemCardTablet(data: data),
      builder: (_, _) => PRFListItemCardTablet(data: data),
    );
  }
}
