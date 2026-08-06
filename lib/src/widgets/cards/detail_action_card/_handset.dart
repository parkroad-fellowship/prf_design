import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFDetailActionCardHandset extends StatelessWidget {
  const PRFDetailActionCardHandset({
    required this.title,
    required this.subtitle,
    this.onTap,
    this.leading,
    this.trailing,
    this.footer,
    this.margin,
    this.padding,
    this.backgroundColor,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final Widget? footer;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: '$title. $subtitle',
      button: onTap != null,
      child: InkWell(
        borderRadius: BorderRadius.circular(PRFRadiusTokens.xl),
        onTap: onTap,
        child: Container(
          margin:
              margin ??
              const EdgeInsets.symmetric(horizontal: PRFSpacingTokens.lg),
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: PRFSpacingTokens.xl,
                vertical: PRFSpacingTokens.xxl,
              ),
          decoration: BoxDecoration(
            color:
                backgroundColor ??
                theme.colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(PRFRadiusTokens.xl),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: PRFSpacingTokens.md),
                  ],
                  Expanded(
                    child: Text(title, style: theme.textTheme.headlineSmall),
                  ),
                  ...switch (trailing) {
                    null => const <Widget>[],
                    final w => <Widget>[w],
                  },
                ],
              ),
              const SizedBox(height: PRFSpacingTokens.lg),
              Text(subtitle, style: theme.textTheme.bodyMedium),
              if (footer != null) ...[
                const SizedBox(height: PRFSpacingTokens.lg),
                footer!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
