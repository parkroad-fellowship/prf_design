import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/cards/action_card/_handset.dart';
import 'package:prf_design/src/widgets/cards/action_card/_tablet.dart';

/// Tappable card with an image and title, adaptive to device size.
///
/// Renders [image] across the card with a gradient overlay and [title]
/// caption. Layout adapts between handset and tablet. Use for photo-based
/// entries (schools, categories, destinations).
///
/// Example:
/// ```dart
/// PRFActionCard(
///   title: school.name,
///   image: CachedNetworkImage(imageUrl: school.photoUrl),
///   onTap: () => _openSchool(school),
/// )
/// ```
class PRFActionCard extends StatelessWidget {
  const PRFActionCard({
    required this.title,
    required this.image,
    super.key,
    this.onTap,
  });

  /// Caption rendered over the image.
  final String title;

  /// The image/illustration widget.
  final Widget image;

  /// Invoked when the card is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFActionCardHandset(
        title: title,
        image: image,
        onTap: onTap,
      ),
      tablet: (_) => PRFActionCardTablet(
        title: title,
        image: image,
        onTap: onTap,
      ),
      builder: (_, _) => PRFActionCardTablet(
        title: title,
        image: image,
        onTap: onTap,
      ),
    );
  }
}
