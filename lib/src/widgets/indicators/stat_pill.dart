import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

// Single-file primitive: the pill is non-interactive and has no layout that
// differs between handset and tablet, so it skips the shell/_handset/_tablet
// split (same rationale as PRFStatusBadge).

/// Colour treatments available on [PRFStatPill].
enum PRFStatPillTone {
  /// Translucent light pill for brand-coloured (primary) headers.
  onPrimary,

  /// Solid primary-container pill for regular surfaces.
  container,
}

/// Compact rounded pill pairing a figure with a short label, e.g. "12 Total".
///
/// Use a row or `Wrap` of these in screen headers to summarise a list. The
/// value is read before the label by screen readers ("12 Total"); pass
/// [semanticLabel] to override. Text grows with the system text scale and
/// wraps rather than overflowing.
///
/// Example:
/// ```dart
/// Wrap(
///   spacing: PRFSpacingTokens.xs,
///   runSpacing: PRFSpacingTokens.xs,
///   children: [
///     PRFStatPill(label: l10n.total, value: payments.length),
///     PRFStatPill(
///       label: l10n.unread,
///       value: unread,
///       icon: Icons.mark_chat_unread_rounded,
///       tone: PRFStatPillTone.container,
///     ),
///   ],
/// )
/// ```
class PRFStatPill extends StatelessWidget {
  const PRFStatPill({
    required this.label,
    required this.value,
    this.icon,
    this.tone = PRFStatPillTone.onPrimary,
    this.semanticLabel,
    super.key,
  });

  /// Short description of the figure, e.g. "Completed".
  final String label;

  /// The figure shown in bold. Rendered with `toString()`, so counts
  /// (`int`) and pre-formatted strings both work.
  final Object value;

  /// Optional leading icon.
  final IconData? icon;

  /// Colour treatment. Defaults to [PRFStatPillTone.onPrimary] for use on
  /// brand-coloured headers.
  final PRFStatPillTone tone;

  /// Overrides the screen-reader label (defaults to "value label").
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final (background, valueColor, labelColor) = switch (tone) {
      PRFStatPillTone.onPrimary => (
        scheme.onPrimary.withValues(alpha: PRFOpacities.muted),
        scheme.onPrimary,
        scheme.onPrimary.withValues(alpha: PRFOpacities.nearOpaque),
      ),
      PRFStatPillTone.container => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
        scheme.onPrimaryContainer,
      ),
    };

    return Semantics(
      container: true,
      label: semanticLabel ?? '$value $label',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: PRFSpacingTokens.md,
          vertical: PRFSpacingTokens.xs,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: PRFSizeTokens.iconSm, color: valueColor),
              const SizedBox(width: PRFSpacingTokens.xs),
            ],
            // Text.rich (not RichText) so the system text scale applies.
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$value ',
                      style: textTheme.labelLarge?.copyWith(
                        color: valueColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: label,
                      style: textTheme.labelMedium?.copyWith(
                        color: labelColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
