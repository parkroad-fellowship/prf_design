import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Branded app bar with a filled primary background and large title.
///
/// Renders the PRF brand colour as the bar background with a rounded back
/// button, bold [title], and optional [actions]. Usable as a standard
/// `Scaffold.appBar`.
///
/// Example:
/// ```dart
/// Scaffold(
///   appBar: PRFBrandedNavBar(
///     title: 'Missions',
///     onBack: () => Navigator.pop(context),
///     actions: [
///       IconButton(
///         icon: const Icon(Icons.settings),
///         onPressed: _openSettings,
///       ),
///     ],
///   ),
///   body: /* ... */,
/// )
/// ```
class PRFBrandedNavBar extends StatelessWidget implements PreferredSizeWidget {
  const PRFBrandedNavBar({
    required this.title,
    super.key,
    this.onBack,
    this.actions,
    this.showBackButton = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  /// Title text.
  final String title;

  /// Invoked when the back button is pressed; defaults to `maybePop`.
  final VoidCallback? onBack;

  /// Optional trailing action widgets.
  final List<Widget>? actions;

  /// When false the back button is hidden. Defaults to true.
  final bool showBackButton;

  /// Overrides the brand-coloured background.
  final Color? backgroundColor;

  /// Overrides the foreground (title/icon) colour.
  final Color? foregroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(96);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.primary;
    final fg = foregroundColor ?? theme.colorScheme.onPrimary;

    return Container(
      color: bg,
      padding: EdgeInsets.fromLTRB(
        PRFSpacingTokens.lg,
        MediaQuery.paddingOf(context).top + PRFSpacingTokens.sm,
        PRFSpacingTokens.lg,
        PRFSpacingTokens.md,
      ),
      child: Row(
        children: [
          if (showBackButton)
            Tooltip(
              message: 'Back',
              child: GestureDetector(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                child: Container(
                  width: PRFSizeTokens.minTouchTarget,
                  height: PRFSizeTokens.minTouchTarget,
                  decoration: BoxDecoration(
                    color: fg.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: PRFSizeTokens.iconMd,
                    color: fg,
                  ),
                ),
              ),
            )
          else
            const SizedBox(width: PRFSizeTokens.minTouchTarget),
          const SizedBox(width: PRFSpacingTokens.md),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: fg,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (actions != null && actions!.isNotEmpty)
            Row(children: actions!)
          else
            const SizedBox(width: 44),
        ],
      ),
    );
  }
}
