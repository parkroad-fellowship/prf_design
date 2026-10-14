import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Tablet layout for PRFNavBar. Internal — prefer the parent widget.
class PRFNavBarTablet extends StatelessWidget {
  const PRFNavBarTablet({
    required this.title,
    required this.centerTitle,
    super.key,
    this.onBack,
    this.actions,
    this.backIcon,
    this.backgroundColor,
    this.isSliver = true,
  });

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final IconData? backIcon;
  final Color? backgroundColor;
  final bool centerTitle;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isSliver) {
      return _buildSliverAppBar(theme, context);
    } else {
      return _buildAppBar(theme, context);
    }
  }

  Widget _buildSliverAppBar(ThemeData theme, BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      pinned: true,
      elevation: PRFElevationTokens.none,
      toolbarHeight: PRFNavigationTokens.appBarHeightTablet,
      flexibleSpace: _buildAppBarContent(theme, context),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme, BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: PRFElevationTokens.none,
      toolbarHeight: PRFNavigationTokens.appBarHeightTablet,
      flexibleSpace: _buildAppBarContent(theme, context),
    );
  }

  Widget _buildAppBarContent(ThemeData theme, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PRFSpacingTokens.xxxl,
        vertical: PRFSpacingTokens.lg,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(
              alpha: PRFOpacities.muted,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
              boxShadow: PRFShadowTokens.card(theme.colorScheme.shadow),
            ),
            child: IconButton(
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              iconSize: 56,
              icon: Icon(
                backIcon ?? Icons.arrow_back_ios_new,
                color: theme.colorScheme.onPrimaryContainer,
                size: PRFSizeTokens.iconLg,
              ),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(width: PRFSpacingTokens.xxl),
          Expanded(
            child: Align(
              alignment: centerTitle
                  ? AlignmentDirectional.center
                  : AlignmentDirectional.centerStart,
              child: Text(
                title,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                // Two lines fit the toolbar at default text size; at large
                // system text sizes only one line fits, so truncate instead
                // of clipping mid-glyph.
                maxLines: MediaQuery.textScalerOf(context).scale(1) > 1.3
                    ? 1
                    : 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (actions != null && actions!.isNotEmpty)
            Row(children: actions!)
          else
            const SizedBox(width: 56),
        ],
      ),
    );
  }
}
