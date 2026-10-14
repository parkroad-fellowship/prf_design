import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';

/// ThemeExtension providing access to PRF brand anchor colors.
///
/// Access via BuildContext:
/// ```dart
/// final colors = Theme.of(context).extension<PRFColorsExtension>()!;
/// // or with the convenience extension:
/// final colors = context.prfColors;
/// ```
///
/// Only brand anchors and accents are exposed here. Surfaces, containers and
/// on-colors are derived by `PRFTheme` and should be read from
/// `Theme.of(context).colorScheme` instead.
///
/// **These are fill colours.** Values are identical in light and dark mode so
/// brand surfaces (a navy header, a lime highlight) look the same in both.
/// They are not guaranteed to be readable as text or icons on theme
/// surfaces. On the dark surface (`navy900`):
///
/// | Field | As foreground on dark surface |
/// |---|---|
/// | [navyBlue] | 1.3:1 — fill only, never text |
/// | [purple] | 3.6:1 — icons / large text only |
/// | [blue] | 4.4:1 — icons / large text only |
/// | [limeGreen], [orange], [emerald] | ≥ 4.6:1 — safe |
///
/// For brand-coloured text use `colorScheme.primary` (navy in light,
/// periwinkle in dark) or `colorScheme.secondary`; for status text use
/// `context.statusColors.<status>.foreground`.
@immutable
class PRFColorsExtension extends ThemeExtension<PRFColorsExtension> {
  const PRFColorsExtension({
    required this.navyBlue,
    required this.limeGreen,
    required this.purple,
    required this.blue,
    required this.orange,
    required this.emerald,
  });

  /// Primary brand anchor (navy). Fill only: use `colorScheme.primary` for
  /// navy text/icons so dark mode stays legible.
  final Color navyBlue;

  /// Secondary brand anchor (lime).
  final Color limeGreen;

  /// Accent purple. Fill / large text only on dark surfaces.
  final Color purple;

  /// Accent blue. Fill / large text only on dark surfaces.
  final Color blue;

  /// Accent orange.
  final Color orange;

  /// Accent emerald.
  final Color emerald;

  /// Brand anchors and accents are identical in both brightness modes —
  /// they are brand identity, not theme surfaces.
  static const light = PRFColorsExtension(
    navyBlue: PRFColors.navyBlue,
    limeGreen: PRFColors.limeGreen,
    purple: PRFColors.purple,
    blue: PRFColors.blue,
    orange: PRFColors.orange,
    emerald: PRFColors.emerald,
  );

  /// Alias of [light]: brand fills do not shift with brightness. See the
  /// class docs for which fields are safe as foreground on dark surfaces.
  static const PRFColorsExtension dark = light;

  @override
  PRFColorsExtension copyWith({
    Color? navyBlue,
    Color? limeGreen,
    Color? purple,
    Color? blue,
    Color? orange,
    Color? emerald,
  }) {
    return PRFColorsExtension(
      navyBlue: navyBlue ?? this.navyBlue,
      limeGreen: limeGreen ?? this.limeGreen,
      purple: purple ?? this.purple,
      blue: blue ?? this.blue,
      orange: orange ?? this.orange,
      emerald: emerald ?? this.emerald,
    );
  }

  @override
  PRFColorsExtension lerp(PRFColorsExtension? other, double t) {
    if (other is! PRFColorsExtension) return this;
    return PRFColorsExtension(
      navyBlue: Color.lerp(navyBlue, other.navyBlue, t)!,
      limeGreen: Color.lerp(limeGreen, other.limeGreen, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      emerald: Color.lerp(emerald, other.emerald, t)!,
    );
  }
}
