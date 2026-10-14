import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/extensions/theme_context_extensions.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Tappable card with an SVG illustration and a chevron affordance.
///
/// Renders a rounded, shadowed card with an SVG asset, a title, and a circular
/// arrow indicator pinned to the top-right corner (outside the content flow,
/// so it never contributes to the tile's height budget).
///
/// Use for menu-style navigation entries. [isNeutralCard] switches the arrow
/// to a neutral outline style; [accent] renders the Living Root action moment:
/// a navy surface with white text and a lime arrow — reserve it for the single
/// most important action on a screen.
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
    this.accent = false,
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

  /// When true the tile becomes the screen's action moment: navy surface,
  /// white title, lime arrow chip.
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = context.prfColors;
    final arrowBackgroundColor = accent
        ? brand.limeGreen
        : isNeutralCard
        ? theme.colorScheme.surfaceContainerHigh
        : theme.colorScheme.primary.withValues(alpha: PRFOpacities.hairline);
    final arrowIconColor = accent
        ? brand.navyBlue
        : isNeutralCard
        ? theme.colorScheme.onSurfaceVariant
        : theme.colorScheme.primary;
    final arrowBorderColor = !accent && isNeutralCard
        ? theme.colorScheme.outline.withValues(alpha: PRFOpacities.accent)
        : Colors.transparent;
    final surfaceColor = accent ? brand.navyBlue : null;
    // The accent surface is a fixed brand fill in both modes, so its title is
    // fixed white rather than a theme on-colour.
    final titleColor = accent ? PRFColors.white : theme.colorScheme.onSurface;

    return Semantics(
      button: true,
      child: Material(
        color: surfaceColor ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
        child: InkWell(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
              border: Border.all(
                color: accent
                    ? Colors.transparent
                    : theme.colorScheme.outline.withValues(
                        alpha: PRFOpacities.muted,
                      ),
              ),
              boxShadow: PRFShadowTokens.card(theme.colorScheme.shadow),
            ),
            child: Padding(
              padding: const EdgeInsets.all(PRFSpacingTokens.md),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(assetPath, height: assetHeight),
                      const Spacer(),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: titleColor,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      // minimum 48dp touch target for the arrow affordance
                      width: PRFSizeTokens.minTouchTarget,
                      height: PRFSizeTokens.minTouchTarget,
                      decoration: BoxDecoration(
                        color: arrowBackgroundColor,
                        borderRadius: BorderRadius.circular(
                          PRFRadiusTokens.full,
                        ),
                        border: Border.all(color: arrowBorderColor),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: PRFSizeTokens.iconSm,
                        color: arrowIconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
