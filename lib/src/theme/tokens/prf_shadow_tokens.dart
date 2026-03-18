import 'package:flutter/material.dart';

/// Shadow design tokens for consistent elevation and depth.
///
/// Provides pre-built [BoxShadow] lists for common surface types.
/// Use these instead of inline BoxShadow definitions to maintain
/// visual consistency across the app.
abstract final class PRFShadowTokens {
  /// Standard card shadow — subtle depth for content cards.
  ///
  /// Used by: detail cards, FAQ cards, soul cards, subscriber cards, etc.
  static List<BoxShadow> card(Color shadowColor) => [
    BoxShadow(
      color: shadowColor.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: shadowColor.withValues(alpha: 0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Badge/accent shadow — colored glow for status indicators and date badges.
  static List<BoxShadow> badge(Color accentColor) => [
    BoxShadow(
      color: accentColor.withValues(alpha: 0.3),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  /// Elevated surface shadow — stronger depth for floating surfaces.
  static List<BoxShadow> elevated(Color shadowColor) => [
    BoxShadow(
      color: shadowColor.withValues(alpha: 0.12),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: shadowColor.withValues(alpha: 0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}
