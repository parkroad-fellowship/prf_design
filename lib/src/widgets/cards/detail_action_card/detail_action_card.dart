import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/cards/detail_action_card/_handset.dart';
import 'package:prf_design/src/widgets/cards/detail_action_card/_tablet.dart';

/// Tappable detail card with title, subtitle and optional slots.
///
/// Renders [leading], then [title]/[subtitle], then [trailing]; an optional
/// [footer] spans the full width below. Use as a rich list row or summary card.
///
/// Example:
/// ```dart
/// PRFDetailActionCard(
///   title: 'PRF Missions',
///   subtitle: 'Spring 2026 · 3 teams',
///   leading: const Icon(Icons.rocket_launch),
///   trailing: const Icon(Icons.chevron_right),
///   onTap: _openMission,
/// )
/// ```
class PRFDetailActionCard extends StatelessWidget {
  const PRFDetailActionCard({
    required this.title,
    required this.subtitle,
    super.key,
    this.onTap,
    this.leading,
    this.trailing,
    this.footer,
    this.margin,
    this.padding,
    this.backgroundColor,
  });

  /// Main title text.
  final String title;

  /// Supporting subtitle text.
  final String subtitle;

  /// Invoked when the card is tapped.
  final VoidCallback? onTap;

  /// Widget rendered on the leading edge (icon, avatar, thumbnail…).
  final Widget? leading;

  /// Widget rendered on the trailing edge.
  final Widget? trailing;

  /// Full-width widget rendered below the title/subtitle row.
  final Widget? footer;

  /// Overrides the default outer margin.
  final EdgeInsetsGeometry? margin;

  /// Overrides the default inner padding.
  final EdgeInsetsGeometry? padding;

  /// Overrides the card background colour.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFDetailActionCardHandset(
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        leading: leading,
        trailing: trailing,
        footer: footer,
        margin: margin,
        padding: padding,
        backgroundColor: backgroundColor,
      ),
      tablet: (_) => PRFDetailActionCardTablet(
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        leading: leading,
        trailing: trailing,
        footer: footer,
        margin: margin,
        padding: padding,
        backgroundColor: backgroundColor,
      ),
      builder: (_, _) => PRFDetailActionCardTablet(
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        leading: leading,
        trailing: trailing,
        footer: footer,
        margin: margin,
        padding: padding,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
