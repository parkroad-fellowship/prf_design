import 'dart:ui';

/// Centralized semantic status colors used by theme extensions.
abstract final class PRFStatusTokens {
  static const Color pendingBackgroundLight = Color(0xFFFFF7ED);
  static const Color initiatedBackgroundLight = Color(0xFFEFF6FF);
  static const Color inProgressBackgroundLight = Color(0xFFECFDF5);

  static const Color successBackgroundDark = Color(0xFF1A3D2A);
  static const Color warningBackgroundDark = Color(0xFF3D3A1A);
  static const Color errorMainDark = Color(0xFFDC3545);
  static const Color errorBackgroundDark = Color(0xFF3D1A1A);
  static const Color infoBackgroundDark = Color(0xFF1A3D3D);

  static const Color pendingBackgroundDark = Color(0xFF3D2A1A);
  static const Color initiatedBackgroundDark = Color(0xFF1A2A3D);
  static const Color inProgressBackgroundDark = Color(0xFF1A3D2A);

  static const Color activeGlow = Color(0x4010B981);
}
