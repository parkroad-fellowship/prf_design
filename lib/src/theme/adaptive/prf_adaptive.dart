import 'package:flutter/widgets.dart';

import 'package:prf_design/src/theme/adaptive/prf_breakpoints.dart';

/// Routes a widget to a breakpoint-specific implementation.
///
/// Each widget follows the adaptive pattern: a thin public shell that defers
/// all layout to `_handset` / `_tablet` variants via `PRFAdaptive`.
///
/// ```dart
/// PRFAdaptive(
///   builder: (_, _) => PRFMyWidgetTablet(...), // fallback for unhandled sizes
///   handset: (_) => PRFMyWidgetHandset(...),
///   tablet: (_) => PRFMyWidgetTablet(...),
/// )
/// ```
class PRFAdaptive extends StatelessWidget {
  const PRFAdaptive({
    required this.builder,
    super.key,
    this.handset,
    this.tablet,
    this.desktop,
  });

  /// Fallback builder used when no explicit variant matches the breakpoint.
  final Widget Function(BuildContext context, PRFBreakpoint breakpoint) builder;

  /// Handset variant (width < 600).
  final Widget Function(BuildContext context)? handset;

  /// Tablet variant (600 ≤ width < 1024).
  final Widget Function(BuildContext context)? tablet;

  /// Desktop variant (width ≥ 1024).
  final Widget Function(BuildContext context)? desktop;

  @override
  Widget build(BuildContext context) {
    final breakpoint = PRFBreakpoints.of(context);
    final variant = switch (breakpoint) {
      PRFBreakpoint.handset when handset != null => handset!(context),
      PRFBreakpoint.tablet when tablet != null => tablet!(context),
      PRFBreakpoint.desktop when desktop != null => desktop!(context),
      _ => builder(context, breakpoint),
    };
    return variant;
  }
}
