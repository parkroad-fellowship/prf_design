// Shared animated builders for AnimatedStatCard variants.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

Widget buildAnimatedIcon(
  BuildContext context, {
  required IconData icon,
  required Color color,
  required double size,
  required double padding,
  required Duration delay,
}) {
  final widget = Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: size, color: color),
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate(delay: delay)
      .scale(duration: PRFMotionTokens.enterShort, curve: Curves.elasticOut)
      .fadeIn();
}

Widget buildAnimatedValue(
  BuildContext context, {
  required ThemeData theme,
  required String value,
  required Color color,
  required Duration delay,
}) {
  final widget = Text(
    value,
    style: theme.textTheme.displayLarge?.copyWith(
      color: color,
      fontWeight: FontWeight.w800,
    ),
    textAlign: TextAlign.center,
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate(delay: delay)
      .fadeIn(duration: PRFMotionTokens.enterMedium)
      .slideY(begin: 0.3, end: 0, curve: Curves.easeOut);
}

Widget buildAnimatedLabel(
  BuildContext context, {
  required ThemeData theme,
  required String label,
  required Color onSurfaceColor,
  required Duration delay,
}) {
  final widget = Text(
    label,
    style: theme.textTheme.titleLarge?.copyWith(
      color: onSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    textAlign: TextAlign.center,
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate(delay: delay)
      .fadeIn(duration: PRFMotionTokens.enterShort)
      .slideY(begin: 0.3, end: 0);
}
