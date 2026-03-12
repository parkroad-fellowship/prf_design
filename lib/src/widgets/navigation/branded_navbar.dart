import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

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

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color? backgroundColor;
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
            GestureDetector(
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: fg.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: fg,
                ),
              ),
            )
          else
            const SizedBox(width: 44),
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
