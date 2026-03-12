import 'dart:ui';

/// Centralized semantic status colors used by theme extensions.
abstract final class PRFStatusTokens {
  static const Color pendingBackgroundLight = Color(0xFFFFF2E4);
  static const Color initiatedBackgroundLight = Color(0xFFEAF0FF);
  static const Color inProgressBackgroundLight = Color(0xFFE8FAF3);

  static const Color successBackgroundDark = Color(0xFF163C32);
  static const Color warningBackgroundDark = Color(0xFF40341F);
  static const Color errorMainDark = Color(0xFFE25757);
  static const Color errorBackgroundDark = Color(0xFF412226);
  static const Color infoBackgroundDark = Color(0xFF1D355A);

  static const Color pendingBackgroundDark = Color(0xFF463421);
  static const Color initiatedBackgroundDark = Color(0xFF1F2E4F);
  static const Color inProgressBackgroundDark = Color(0xFF193D33);

  static const Color activeGlow = Color(0x4012B886);
}
