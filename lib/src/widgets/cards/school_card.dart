import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// School list tile with icon, name, address, mission count and chevron.
///
/// Renders a tappable card with a school icon, [schoolName] and [address], an
/// optional [missionCount] pill and a trailing chevron.
///
/// Example:
/// ```dart
/// PRFSchoolCard(
///   schoolName: school.name,
///   address: school.address,
///   missionCount: school.missions.length,
///   onTap: () => _openSchool(school),
/// )
/// ```
class PRFSchoolCard extends StatelessWidget {
  const PRFSchoolCard({
    required this.schoolName,
    required this.address,
    required this.onTap,
    super.key,
    this.missionCount,
  });

  /// School name.
  final String schoolName;

  /// School address.
  final String address;

  /// Optional number of missions shown in a pill.
  final int? missionCount;

  /// Invoked when the card is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: '$schoolName. $address',
      button: true,
      child: Material(
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(PRFSpacingTokens.sm),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      size: PRFSizeTokens.iconLg,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: PRFSpacingTokens.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schoolName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: PRFSpacingTokens.xs),
                        Text(
                          address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (missionCount != null) ...[
                    const SizedBox(width: PRFSpacingTokens.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PRFSpacingTokens.sm,
                        vertical: PRFSpacingTokens.xs,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(
                          PRFRadiusTokens.full,
                        ),
                      ),
                      child: Text(
                        '$missionCount',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(width: PRFSpacingTokens.sm),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: PRFSizeTokens.iconMd,
                    color: theme.colorScheme.onSurfaceVariant,
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
