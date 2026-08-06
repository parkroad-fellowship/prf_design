import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Tablet layout for PRFDetailActionCard. Prefer the parent widget.
class PRFDetailActionCardTablet extends StatelessWidget {
  const PRFDetailActionCardTablet({
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
      child: Center(
        child: ConstrainedBox(
          // tablet: limit card width for comfortable reading
          constraints: const BoxConstraints(maxWidth: 680),
          child: InkWell(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.xl),
            onTap: onTap,
            child: Container(
              margin:
                  margin ??
                  const EdgeInsets.symmetric(horizontal: PRFSpacingTokens.xxxl),
              padding:
                  padding ??
                  const EdgeInsets.symmetric(
                    horizontal: PRFSpacingTokens.xxxl,
                    vertical: PRFSpacingTokens.xxxl,
                  ),
              decoration: BoxDecoration(
                color:
                    backgroundColor ??
                    theme.colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(PRFRadiusTokens.xxl),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
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
                        const SizedBox(width: PRFSpacingTokens.lg),
                      ],
                      Expanded(
                        child: Text(
                          title,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                      ...switch (trailing) {
                        null => const <Widget>[],
                        final w => <Widget>[w],
                      },
                    ],
                  ),
                  const SizedBox(height: PRFSpacingTokens.xl),
                  Text(subtitle, style: theme.textTheme.bodyLarge),
                  if (footer != null) ...[
                    const SizedBox(height: PRFSpacingTokens.xl),
                    footer!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
