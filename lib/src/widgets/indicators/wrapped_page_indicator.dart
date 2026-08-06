import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Animated pill-style page indicator (dots turn into a wide bar when active).
///
/// Example:
/// ```dart
/// WrappedPageIndicator(currentPage: _page, pageCount: 5)
/// ```
class WrappedPageIndicator extends StatelessWidget {
  const WrappedPageIndicator({
    required this.currentPage,
    required this.pageCount,
    super.key,
  });

  /// The active page (0-based).
  final int currentPage;

  /// Total number of pages.
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: 'Page ${currentPage + 1} of $pageCount',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pageCount,
          (index) => AnimatedContainer(
            duration: PRFMotionTokens.resolve(context, PRFMotionTokens.slow),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentPage == index ? 32 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentPage == index
                  ? theme.colorScheme.primary
                  : theme.colorScheme.primary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(PRFRadiusTokens.xs),
            ),
          ),
        ),
      ),
    );
  }
}
