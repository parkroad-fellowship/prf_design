import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Tappable card with an SVG illustration and a chevron affordance.
///
/// Renders a rounded, shadowed card with an SVG asset, a title, and a circular
/// arrow indicator. Use for menu-style navigation entries; [isNeutralCard]
/// switches the arrow to a neutral outline style.
///
/// Example:
/// ```dart
/// PRFNavigationTile(
///   title: 'Missions',
///   assetPath: 'assets/missions.svg',
///   onTap: () => _openMissions(),
/// )
/// ```
class PRFNavigationTile extends StatelessWidget {
  const PRFNavigationTile({
    required this.title,
    required this.assetPath,
    required this.onTap,
    super.key,
    this.assetHeight = 56,
    this.isNeutralCard = false,
  });

  /// Card title, shown under the asset.
  final String title;

  /// Asset path of the SVG illustration.
  final String assetPath;

  /// Invoked when the card is tapped.
  final VoidCallback onTap;

  /// Height of the SVG asset. Defaults to 56.
  final double assetHeight;

  /// When true the arrow affordance uses the neutral outline style.
  final bool isNeutralCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final arrowBackgroundColor = isNeutralCard
        ? theme.colorScheme.surfaceContainerHigh
        : theme.colorScheme.primary.withValues(alpha: 0.12);
    final arrowIconColor = isNeutralCard
        ? theme.colorScheme.onSurfaceVariant
        : theme.colorScheme.primary;
    final arrowBorderColor = isNeutralCard
        ? theme.colorScheme.outline.withValues(alpha: 0.35)
        : Colors.transparent;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.surfaceContainerLowest,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(PRFSpacingTokens.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    // minimum 48dp touch target for the arrow affordance
                    width: PRFSizeTokens.minTouchTarget,
                    height: PRFSizeTokens.minTouchTarget,
                    decoration: BoxDecoration(
                      color: arrowBackgroundColor,
                      borderRadius: BorderRadius.circular(PRFRadiusTokens.full),
                      border: Border.all(color: arrowBorderColor),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: PRFSizeTokens.iconSm,
                      color: arrowIconColor,
                    ),
                  ),
                ),
                const SizedBox(height: PRFSpacingTokens.xs),
                SvgPicture.asset(assetPath, height: assetHeight),
                const Spacer(),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
