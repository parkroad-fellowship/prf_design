import 'package:flutter/material.dart';

/// Standard tablet split scaffold: centered max-width stage with a main
/// content column and a side panel column separated by a hairline divider.
///
/// This is the canonical tablet geometry for list/detail screens:
///
/// ```dart
/// PRFTabletSplitScaffold(
///   content: Column(children: [header, list]),
///   sidePanel: PRFBrandPanel(child: ...),
/// )
/// ```
class PRFTabletSplitScaffold extends StatelessWidget {
  const PRFTabletSplitScaffold({
    required this.content,
    required this.sidePanel,
    super.key,
    this.contentFlex = 3,
    this.sidePanelFlex = 2,
    this.maxWidth = 1100,
    this.showDivider = true,
  });

  /// Main working area of the screen (lists, tabs, forms).
  final Widget content;

  /// Right-hand supporting column (brand panel, summary rail, filters).
  final Widget sidePanel;

  /// Flex weight of the content column. Defaults to 3.
  final int contentFlex;

  /// Flex weight of the side panel column. Defaults to 2.
  final int sidePanelFlex;

  /// Maximum width of the split stage. Content centers beyond this width.
  /// Defaults to 1100.
  final double maxWidth;

  /// Whether to draw the hairline divider between the columns.
  /// Defaults to true.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: contentFlex, child: content),
                if (showDivider)
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: theme.colorScheme.outline.withValues(alpha: 0.12),
                  ),
                Expanded(flex: sidePanelFlex, child: sidePanel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
