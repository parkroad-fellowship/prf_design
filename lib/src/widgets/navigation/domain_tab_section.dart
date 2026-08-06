import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// A titled tab section that fills the remaining vertical space.
///
/// Renders a card with [title], [subtitle] and a scrollable [TabBar] of [tabs]
/// above a `TabBarView` of [children]. One [children] entry per tab.
///
/// Example:
/// ```dart
/// PRFDomainTabSection(
///   title: 'Missions',
///   subtitle: 'Explore by status',
///   tabs: const [
///     Tab(text: 'Active'),
///     Tab(text: 'Past'),
///   ],
///   children: [
///     _ActiveMissions(),
///     _PastMissions(),
///   ],
/// )
/// ```
class PRFDomainTabSection extends StatelessWidget {
  const PRFDomainTabSection({
    required this.title,
    required this.subtitle,
    required this.tabs,
    required this.children,
    super.key,
  });

  /// Section heading.
  final String title;

  /// Supporting text under the heading.
  final String subtitle;

  /// One tab per [children] entry.
  final List<Widget> tabs;

  /// One body view per tab.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(
              PRFSpacingTokens.lg,
              PRFSpacingTokens.lg,
              PRFSpacingTokens.lg,
              PRFSpacingTokens.sm,
            ),
            padding: const EdgeInsets.all(PRFSpacingTokens.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: PRFSpacingTokens.xs),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: PRFSpacingTokens.sm),
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  padding: EdgeInsets.zero,
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: PRFSpacingTokens.sm,
                  ),
                  labelColor: theme.colorScheme.onSurface,
                  unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                  indicatorColor: theme.colorScheme.primary,
                  tabs: tabs,
                ),
              ],
            ),
          ),
          Expanded(child: TabBarView(children: children)),
        ],
      ),
    );
  }
}
