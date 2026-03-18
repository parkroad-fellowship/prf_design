import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFNavigationTile extends StatelessWidget {
  const PRFNavigationTile({
    required this.title,
    required this.assetPath,
    required this.onTap,
    super.key,
    this.assetHeight = 56,
    this.isNeutralCard = false,
  });

  final String title;
  final String assetPath;
  final VoidCallback onTap;
  final double assetHeight;
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
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: arrowBackgroundColor,
                      borderRadius: BorderRadius.circular(PRFRadiusTokens.full),
                      border: Border.all(color: arrowBorderColor),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
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
