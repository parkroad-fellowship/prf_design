import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/tokens/prf_radius_tokens.dart';
import 'package:prf_design/src/theme/tokens/prf_spacing_tokens.dart';
import 'package:prf_design/src/widgets/cards/timeline_date_badge.dart';

/// A model-agnostic mission timeline card.
///
/// This widget is intentionally data-shape independent: all display values are
/// passed through constructor parameters.
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

  final bool isLast;
  final DateTime startDate;
  final DateTime? endDate;
  final Color statusColor;
  final String statusText;
  final String schoolName;
  final String missionTypeName;
  final String durationLabel;
  final String durationValue;
  final String capacityLabel;
  final String capacityValue;
  final String datePrimaryText;
  final String? dateSecondaryText;
  final bool showActiveIndicator;
  final Color? activeIndicatorColor;
  final String actionLabel;
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
    final actionTextColor = isDark ? theme.colorScheme.onSurface : statusColor;

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
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
                border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: statusColor.withValues(alpha: 0.05),
                    blurRadius: 24,
                    offset: const Offset(0, 6),
                  ),
                ],
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
                                  color: theme.colorScheme.secondary,
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
                                alpha: isDark ? 0.18 : 0.1,
                              ),
                              borderRadius: BorderRadius.circular(
                                PRFRadiusTokens.sm,
                              ),
                              border: Border.all(
                                color: statusColor.withValues(
                                  alpha: isDark ? 0.45 : 0.3,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  actionLabel,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: actionTextColor,
                                  ),
                                ),
                                const SizedBox(width: PRFSpacingTokens.xs),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 14,
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
            statusColor.withValues(alpha: 0.1),
            statusColor.withValues(alpha: 0.05),
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
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  statusText,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PRFColors.white,
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
                  size: 16,
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
    final isDark = theme.brightness == Brightness.dark;
    final labelColor = theme.colorScheme.onSurface.withValues(
      alpha: isDark ? 0.82 : 0.72,
    );
    final valueColor = theme.colorScheme.onSurface.withValues(
      alpha: isDark ? 0.98 : 0.9,
    );

    return Container(
      padding: const EdgeInsets.all(PRFSpacingTokens.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: color),
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
          const SizedBox(height: 2),
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
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(PRFSpacingTokens.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 16,
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
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: isDark ? 0.78 : 0.68,
                      ),
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
                boxShadow: [
                  BoxShadow(
                    color: activeIndicatorColor.withValues(alpha: 0.5),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
