import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/extensions/theme_context_extensions.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/cards/timeline_date_badge.dart';

/// A model-agnostic mission timeline card.
///
/// This widget is intentionally data-shape independent: all display values are
/// passed through constructor parameters. Renders a [PRFTimelineDateBadge]
/// beside a card with status header, duration/capacity chips, a date range
/// view and a full-width action row.
///
/// Example:
/// ```dart
/// PRFTimelineMissionCard(
///   isLast: index == missions.length - 1,
///   startDate: mission.startDate,
///   endDate: mission.endDate,
///   statusColor: context.statusColors.completed.main,
///   statusText: 'Completed',
///   schoolName: mission.school.name,
///   missionTypeName: mission.type.label,
///   durationLabel: 'Duration',
///   durationValue: mission.durationLabel,
///   capacityLabel: 'Capacity',
///   capacityValue: mission.capacityLabel,
///   datePrimaryText: mission.dateLabel,
///   actionLabel: 'View details',
///   onTap: () => _openMission(mission),
/// )
/// ```
class PRFTimelineMissionCard extends StatelessWidget {
  const PRFTimelineMissionCard({
    required this.isLast,
    required this.startDate,
    required this.statusColor,
    required this.statusText,
    required this.schoolName,
    required this.missionTypeName,
    required this.durationLabel,
    required this.durationValue,
    required this.capacityLabel,
    required this.capacityValue,
    required this.datePrimaryText,
    required this.actionLabel,
    this.endDate,
    this.dateSecondaryText,
    this.showActiveIndicator = false,
    this.activeIndicatorColor,
    this.onTap,
    super.key,
  });

  /// Whether this is the last item in the timeline (hides the connector).
  final bool isLast;

  /// Start date of the mission; also drives the date badge.
  final DateTime startDate;

  /// End date for multi-day ranges. When null the badge shows a single day.
  final DateTime? endDate;

  /// Accent colour for the badge, header and action row.
  final Color statusColor;

  /// Status label shown in the header badge.
  final String statusText;

  /// School name shown in the card header.
  final String schoolName;

  /// Mission type label shown under the school name.
  final String missionTypeName;

  /// Label of the duration info chip.
  final String durationLabel;

  /// Value of the duration info chip.
  final String durationValue;

  /// Label of the capacity info chip.
  final String capacityLabel;

  /// Value of the capacity info chip.
  final String capacityValue;

  /// Primary line of the date range view.
  final String datePrimaryText;

  /// Optional secondary line of the date range view.
  final String? dateSecondaryText;

  /// When true a glowing dot marks the mission as active.
  final bool showActiveIndicator;

  /// Colour of the active dot; defaults to [statusColor].
  final Color? activeIndicatorColor;

  /// Label of the full-width action row.
  final String actionLabel;

  /// Invoked when the card is tapped.
  final VoidCallback? onTap;

  bool get _isMultiDay =>
      endDate != null &&
      (startDate.year != endDate!.year ||
          startDate.month != endDate!.month ||
          startDate.day != endDate!.day);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Text on the status tint: prefer the matching set's AA-safe foreground.
    final statusSet = context.statusColors.all
        .where((set) => set.main == statusColor)
        .firstOrNull;
    final actionTextColor =
        statusSet?.foreground ??
        (isDark ? theme.colorScheme.onSurface : statusColor);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PRFTimelineDateBadge(
          startDate: startDate,
          endDate: _isMultiDay ? endDate : null,
          statusColor: statusColor,
          isLast: isLast,
        ),
        const SizedBox(width: PRFSpacingTokens.lg),
        Expanded(
          child: Semantics(
            button: true,
            label: '$schoolName, $statusText',
            hint: actionLabel,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: isLast ? 0 : PRFSpacingTokens.lg,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
                    border: Border.all(
                      color: statusColor.withValues(alpha: PRFOpacities.muted),
                    ),
                    boxShadow: PRFShadowTokens.card(theme.colorScheme.shadow),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Header(
                          statusColor: statusColor,
                          statusText: statusText,
                          schoolName: schoolName,
                          missionTypeName: missionTypeName,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(PRFSpacingTokens.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _InfoChip(
                                      icon: Icons.access_time_rounded,
                                      label: durationLabel,
                                      value: durationValue,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: PRFSpacingTokens.sm),
                                  Expanded(
                                    child: _InfoChip(
                                      icon: Icons.people_rounded,
                                      label: capacityLabel,
                                      value: capacityValue,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: PRFSpacingTokens.md),
                              _DateRangeView(
                                datePrimaryText: datePrimaryText,
                                dateSecondaryText: dateSecondaryText,
                                showActiveIndicator: showActiveIndicator,
                                activeIndicatorColor:
                                    activeIndicatorColor ?? statusColor,
                              ),
                              const SizedBox(height: PRFSpacingTokens.md),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: PRFSpacingTokens.lg,
                                  vertical: PRFSpacingTokens.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(
                                    alpha: isDark
                                        ? PRFOpacities.muted
                                        : PRFOpacities.subtle,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    PRFRadiusTokens.sm,
                                  ),
                                  border: Border.all(
                                    color: statusColor.withValues(
                                      alpha: isDark
                                          ? PRFOpacities.half
                                          : PRFOpacities.glow,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      actionLabel,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: actionTextColor,
                                          ),
                                    ),
                                    const SizedBox(width: PRFSpacingTokens.xs),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: PRFSizeTokens.iconSm,
                                      color: actionTextColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.statusColor,
    required this.statusText,
    required this.schoolName,
    required this.missionTypeName,
  });

  final Color statusColor;
  final String statusText;
  final String schoolName;
  final String missionTypeName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(PRFSpacingTokens.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            statusColor.withValues(alpha: PRFOpacities.subtle),
            statusColor.withValues(alpha: PRFOpacities.faint),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  schoolName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: PRFSpacingTokens.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PRFSpacingTokens.sm,
                  vertical: PRFSpacingTokens.xs,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
                  boxShadow: PRFShadowTokens.badge(statusColor),
                ),
                child: Text(
                  statusText,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.statusColors.onColorFor(statusColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: PRFSpacingTokens.md),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(PRFSpacingTokens.xs),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
                ),
                child: Icon(
                  Icons.school_rounded,
                  size: PRFSizeTokens.iconSm,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: PRFSpacingTokens.sm),
              Expanded(
                child: Text(
                  missionTypeName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelColor = theme.colorScheme.onSurfaceVariant;
    final valueColor = theme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.all(PRFSpacingTokens.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: PRFOpacities.subtle),
        borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
        border: Border.all(color: color.withValues(alpha: PRFOpacities.muted)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: PRFSizeTokens.iconXs, color: color),
              const SizedBox(width: PRFSpacingTokens.xs),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: labelColor,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: PRFSpacingTokens.xs / 2),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _DateRangeView extends StatelessWidget {
  const _DateRangeView({
    required this.datePrimaryText,
    required this.showActiveIndicator,
    required this.activeIndicatorColor,
    this.dateSecondaryText,
  });

  final String datePrimaryText;
  final String? dateSecondaryText;
  final bool showActiveIndicator;
  final Color activeIndicatorColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(PRFSpacingTokens.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(
            alpha: PRFOpacities.muted,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: PRFSizeTokens.iconSm,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: PRFSpacingTokens.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  datePrimaryText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (dateSecondaryText != null)
                  Text(
                    dateSecondaryText!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (showActiveIndicator)
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: activeIndicatorColor,
                shape: BoxShape.circle,
                boxShadow: PRFShadowTokens.badge(activeIndicatorColor),
              ),
            ),
        ],
      ),
    );
  }
}
