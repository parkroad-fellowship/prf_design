import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

// Single-file primitive: a header button has one layout on every device, so
// it skips the shell/_handset/_tablet split (same as PRFButton).

/// Visual treatments for [PRFNavBarAction].
enum PRFNavBarActionVariant {
  /// Filled secondary (lime) button — the screen's main header action.
  primary,

  /// Translucent outlined button for supporting header actions.
  neutral,
}

/// Labelled action button for the trailing slot of `PRFBrandedNavBar`.
///
/// Always shows its [label] (with an optional [icon]) so the action is clear
/// without guessing, and is at least 48 dp tall. Screen readers announce it
/// as a button named [label]; [tooltip] adds extra long-press help.
///
/// Designed for a primary-coloured header background.
///
/// Example:
/// ```dart
/// PRFBrandedNavBar(
///   title: 'Professions',
///   actions: [
///     PRFNavBarAction(
///       label: 'New',
///       icon: Icons.add,
///       tooltip: 'Add a profession',
///       onPressed: () => _showForm(context),
///     ),
///   ],
/// )
/// ```
class PRFNavBarAction extends StatelessWidget {
  const PRFNavBarAction({
    required this.label,
    required this.onPressed,
    this.icon,
    this.tooltip,
    this.variant = PRFNavBarActionVariant.primary,
    super.key,
  });

  /// Visible button text; also the screen-reader name.
  final String label;

  /// Invoked when tapped. When null the button is shown disabled.
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional long-press help text. Defaults to no tooltip, since [label] is
  /// already visible.
  final String? tooltip;

  /// Visual treatment. Defaults to [PRFNavBarActionVariant.primary].
  final PRFNavBarActionVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isPrimary = variant == PRFNavBarActionVariant.primary;
    final enabled = onPressed != null;

    final background = isPrimary
        ? scheme.secondary
        : scheme.onPrimary.withValues(alpha: PRFOpacities.hairline);
    final foreground = isPrimary ? scheme.onSecondary : scheme.onPrimary;
    final radius = BorderRadius.circular(PRFRadiusTokens.md);

    Widget button = Opacity(
      opacity: enabled ? 1 : PRFOpacities.half,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: isPrimary && enabled
              ? PRFShadowTokens.raised(scheme.shadow)
              : null,
        ),
        child: Material(
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: scheme.onPrimary.withValues(
                      alpha: PRFOpacities.muted,
                    ),
                  ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: PRFSizeTokens.minTouchTarget,
                minWidth: PRFSizeTokens.minTouchTarget,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PRFSpacingTokens.md,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: PRFSizeTokens.iconMd, color: foreground),
                      const SizedBox(width: PRFSpacingTokens.xs),
                    ],
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: foreground,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    button = Semantics(
      button: true,
      enabled: enabled,
      label: label,
      onTap: onPressed,
      excludeSemantics: true,
      child: button,
    );

    final tip = tooltip;
    if (tip != null && tip.isNotEmpty) {
      button = Tooltip(message: tip, child: button);
    }
    return button;
  }
}
