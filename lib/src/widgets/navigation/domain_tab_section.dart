import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// A titled tab section that fills the remaining vertical space.
///
/// Renders a card with [title], an optional [subtitle] and a scrollable
/// [TabBar] of [tabs] above a `TabBarView` of [children]. One [children]
/// entry per tab.
///
/// The section owns its own [TabController], so callers need no
/// `DefaultTabController`. Use [initialIndex] to choose the first tab and
/// [onTabChanged] to react when the user settles on another tab (by tapping
/// or swiping).
///
/// Example:
/// ```dart
/// PRFDomainTabSection(
///   title: 'Missions',
///   subtitle: 'Explore by status',
///   initialIndex: 1,
///   onTabChanged: (index) => _loadTab(index),
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
class PRFDomainTabSection extends StatefulWidget {
  const PRFDomainTabSection({
    required this.title,
    required this.tabs,
    required this.children,
    this.subtitle,
    this.onTabChanged,
    this.initialIndex = 0,
    super.key,
  }) : assert(
         tabs.length == children.length,
         'tabs and children must have the same length',
       );

  /// Section heading.
  final String title;

  /// Optional supporting text under the heading.
  final String? subtitle;

  /// One tab per [children] entry.
  final List<Widget> tabs;

  /// One body view per tab.
  final List<Widget> children;

  /// Invoked with the new index once the user settles on a different tab.
  final ValueChanged<int>? onTabChanged;

  /// Index of the tab selected on first build. Clamped to the valid range.
  final int initialIndex;

  @override
  State<PRFDomainTabSection> createState() => _PRFDomainTabSectionState();
}

class _PRFDomainTabSectionState extends State<PRFDomainTabSection>
    with TickerProviderStateMixin {
  late TabController _controller;
  late int _lastReportedIndex;

  @override
  void initState() {
    super.initState();
    _controller = _createController(widget.initialIndex);
  }

  TabController _createController(int index) {
    final length = widget.tabs.length;
    final safeIndex = length == 0 ? 0 : index.clamp(0, length - 1);
    _lastReportedIndex = safeIndex;
    return TabController(length: length, vsync: this, initialIndex: safeIndex)
      ..addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_controller.indexIsChanging) return;
    final index = _controller.index;
    if (index == _lastReportedIndex) return;
    _lastReportedIndex = index;
    widget.onTabChanged?.call(index);
  }

  @override
  void didUpdateWidget(PRFDomainTabSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      final previous = _controller.index;
      _controller
        ..removeListener(_handleTabChange)
        ..dispose();
      _controller = _createController(previous);
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleTabChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitle = widget.subtitle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              color: theme.colorScheme.outline.withValues(
                alpha: PRFOpacities.muted,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  widget.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (subtitle != null && subtitle.isNotEmpty) ...[
                const SizedBox(height: PRFSpacingTokens.xs),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: PRFSpacingTokens.sm),
              TabBar(
                controller: _controller,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: PRFSpacingTokens.sm,
                ),
                labelColor: theme.colorScheme.onSurface,
                unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                indicatorColor: theme.colorScheme.primary,
                tabs: widget.tabs,
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(controller: _controller, children: widget.children),
        ),
      ],
    );
  }
}
