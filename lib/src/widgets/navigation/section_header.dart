import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Bold section heading with an optional subtitle line.
///
/// Example:
/// ```dart
/// PRFSectionHeader(
///   title: 'Upcoming missions',
///   subtitle: '3 missions this quarter',
///   padding: const EdgeInsets.all(PRFSpacingTokens.md),
/// )
/// ```
class PRFSectionHeader extends StatelessWidget {
  const PRFSectionHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  /// Heading text.
  final String title;

  /// Optional supporting text under the heading.
  final String? subtitle;

  /// Outer padding. Defaults to `EdgeInsets.zero`.
  final EdgeInsetsGeometry? padding;

  /// Alignment of the heading block. Defaults to [CrossAxisAlignment.start].
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.left,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: PRFSpacingTokens.sm),
            Text(
              subtitle!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ],
      ),
    );
  }
}
