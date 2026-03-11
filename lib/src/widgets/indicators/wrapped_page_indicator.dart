import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class WrappedPageIndicator extends StatelessWidget {
  const WrappedPageIndicator({
    required this.currentPage,
    required this.pageCount,
    super.key,
  });

  final int currentPage;
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
            duration: PRFMotionTokens.slow,
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
