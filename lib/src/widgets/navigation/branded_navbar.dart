import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Branded app bar with a filled primary background and large title.
///
/// Renders the PRF brand colour as the bar background with a rounded back
/// button, bold [title], and optional [actions]. Usable as a standard
/// `Scaffold.appBar`. Prefer `PRFNavBarAction` for [actions]: it is labelled,
/// 48 dp tall and styled for this bar.
///
/// Example:
/// ```dart
/// Scaffold(
///   appBar: PRFBrandedNavBar(
///     title: 'Missions',
///     onBack: () => Navigator.pop(context),
///     actions: [
///       PRFNavBarAction(
///         label: 'New',
///         icon: Icons.add,
///         onPressed: _create,
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
    this.backLabel = 'Back',
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

  /// Tooltip and screen-reader label for the back button. Defaults to "Back".
  final String backLabel;

  @override
  Size get preferredSize =>
      const Size.fromHeight(PRFNavigationTokens.brandedNavBarHeight);

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
            Semantics(
              button: true,
              label: backLabel,
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
              excludeSemantics: true,
              child: Tooltip(
                message: backLabel,
                excludeFromSemantics: true,
                child: Material(
                  color: fg.withValues(alpha: PRFOpacities.hairline),
                  borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onBack ?? () => Navigator.of(context).maybePop(),
                    child: SizedBox(
                      width: PRFSizeTokens.minTouchTarget,
                      height: PRFSizeTokens.minTouchTarget,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: PRFSizeTokens.iconMd,
                        color: fg,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            const SizedBox(width: PRFSizeTokens.minTouchTarget),
          const SizedBox(width: PRFSpacingTokens.md),
          Expanded(
            child: Semantics(
              header: true,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          if (actions != null && actions!.isNotEmpty)
            // Cap the trailing slot so large text scales can't push the
            // title off-screen; labelled actions ellipsize instead.
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final action in actions!) Flexible(child: action),
                ],
              ),
            )
          else
            const SizedBox(width: PRFSizeTokens.minTouchTarget),
        ],
      ),
    );
  }
}
