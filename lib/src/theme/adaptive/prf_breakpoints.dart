import 'package:flutter/widgets.dart';

/// Device size buckets used by the adaptive layer.
enum PRFBreakpoint { handset, tablet, desktop }

/// Breakpoint helpers for adaptive layout.
abstract final class PRFBreakpoints {
  /// Minimum width for tablet layouts.
  static const double tabletMin = 600;

  /// Minimum width for desktop layouts.
  static const double desktopMin = 1024;

  /// Resolves the current breakpoint from the ambient [MediaQuery].
  static PRFBreakpoint of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);

  /// Resolves a breakpoint from a raw width.
  static PRFBreakpoint fromWidth(double width) {
    if (width >= desktopMin) return PRFBreakpoint.desktop;
    if (width >= tabletMin) return PRFBreakpoint.tablet;
    return PRFBreakpoint.handset;
  }

  /// True when the current device is tablet-sized or wider.
  static bool isTabletOrWider(BuildContext context) =>
      of(context) != PRFBreakpoint.handset;
}
