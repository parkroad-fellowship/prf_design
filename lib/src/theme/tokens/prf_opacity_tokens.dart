/// Opacity steps for tinted overlays, borders, glows and disabled content.
///
/// Values mirror the app's observed usage distribution so adoption is a
/// zero-visual-change migration. One-off blend values that exist only inside
/// specific gradients stay inline by design.
abstract final class PRFOpacities {
  /// Faintest step — whisper-level tints and layered washes.
  static const double faint = 0.05;

  /// Soft tints — surface washes and gentle fills.
  static const double subtle = 0.1;

  /// Hairline opacity — borders, separators and outlines at rest.
  static const double hairline = 0.12;

  /// Muted emphasis — secondary borders and inactive fills.
  static const double muted = 0.2;

  /// Glow strength — colored halos and badge shadows.
  static const double glow = 0.3;

  /// Accent strength — brighter decorative accents.
  static const double accent = 0.35;

  /// Half strength.
  static const double half = 0.5;

  /// Prominent content — dimmed but clearly readable.
  static const double prominent = 0.6;

  /// High emphasis — near-primary supporting content.
  static const double high = 0.7;

  /// Strong emphasis — slightly faded primary content.
  static const double stronger = 0.8;

  /// Near-opaque — barely faded primary content.
  static const double nearOpaque = 0.9;
}
