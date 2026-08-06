import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Handset layout for PRFNavBar. Internal — prefer the parent widget.
class PRFNavBarHandset extends StatelessWidget {
  const PRFNavBarHandset({
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
      toolbarHeight: PRFNavigationTokens.appBarHeightHandset,
      flexibleSpace: _buildAppBarContent(theme, context),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme, BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: PRFElevationTokens.none,
      toolbarHeight: PRFNavigationTokens.appBarHeightHandset,
      flexibleSpace: _buildAppBarContent(theme, context),
    );
  }

  Widget _buildAppBarContent(ThemeData theme, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PRFSpacingTokens.lg,
        vertical: PRFSpacingTokens.md,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: .2),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                backIcon ?? Icons.arrow_back_ios_new,
                color: theme.colorScheme.onPrimaryContainer,
                size: 20,
              ),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            ),
          ),
          Expanded(
            child: Align(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: centerTitle ? TextAlign.center : TextAlign.left,
              ),
            ),
          ),
          if (actions != null && actions!.isNotEmpty)
            Row(children: actions!)
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}
