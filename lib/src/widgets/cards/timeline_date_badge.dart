import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/tokens/prf_radius_tokens.dart';
import 'package:prf_design/src/theme/tokens/prf_shadow_tokens.dart';
import 'package:prf_design/src/theme/tokens/prf_spacing_tokens.dart';

/// A timeline date badge with an optional connector line.
///
/// Displays a gradient-colored date indicator used in timeline views
/// (missions, events, sessions). Supports single-day and multi-day ranges.
///
/// The badge shows the day number and month abbreviation. For multi-day
/// ranges, it shows both start and end dates separated by a divider.
///
/// Set [isLast] to `true` to hide the vertical connector line below the badge.
///
/// Example:
/// ```dart
/// PRFTimelineDateBadge(
///   startDate: mission.startDate,
///   endDate: mission.endDate,
///   statusColor: context.statusColors.inProgress.main,
///   isLast: index == items.length - 1,
/// )
/// ```
class PRFTimelineDateBadge extends StatelessWidget {
  const PRFTimelineDateBadge({
    required this.startDate,
    required this.statusColor,
    this.endDate,
    this.isLast = false,
    this.connectorHeight = 60,
    this.badgeWidth = 50,
    super.key,
  });

  /// The start date to display.
  final DateTime startDate;

  /// The end date for multi-day ranges. If null, treated as single-day.
  final DateTime? endDate;

  /// The accent color for the badge gradient and connector.
  final Color statusColor;

  /// Whether this is the last item in the timeline (hides connector).
  final bool isLast;

  /// Height of the connector line below the badge.
  final double connectorHeight;

  /// Width of the date badge.
  final double badgeWidth;

  bool get _isMultiDay =>
      endDate != null &&
      (startDate.year != endDate!.year ||
          startDate.month != endDate!.month ||
          startDate.day != endDate!.day);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: _isMultiDay
          ? '${_monthAbbreviation(startDate.month)} ${startDate.day} '
                'to ${_monthAbbreviation(endDate!.month)} ${endDate!.day}'
          : '${_monthAbbreviation(startDate.month)} ${startDate.day}',
      child: SizedBox(
        width: badgeWidth + 10,
        child: Column(
          children: [
            // Date badge
            Container(
              width: badgeWidth,
              height: _isMultiDay ? 100 : 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    statusColor,
                    statusColor.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
                boxShadow: PRFShadowTokens.badge(statusColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isMultiDay) ...[
                    // Start date
                    Text(
                      startDate.day.toString(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: PRFColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      _monthAbbreviation(startDate.month),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: PRFColors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Divider
                    Container(
                      width: 12,
                      height: 1,
                      color: PRFColors.white.withValues(alpha: 0.7),
                      margin: const EdgeInsets.symmetric(vertical: 2),
                    ),
                    // End date
                    Text(
                      endDate!.day.toString(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: PRFColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      _monthAbbreviation(endDate!.month),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: PRFColors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ] else ...[
                    // Single day
                    Text(
                      startDate.day.toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: PRFColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      _monthAbbreviation(startDate.month),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: PRFColors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Connector line
            if (!isLast)
              Container(
                width: 2,
                height: connectorHeight,
                margin: const EdgeInsets.symmetric(
                  vertical: PRFSpacingTokens.sm,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      statusColor.withValues(alpha: 0.6),
                      theme.colorScheme.outline.withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _monthAbbreviation(int month) => _months[month - 1];
}
