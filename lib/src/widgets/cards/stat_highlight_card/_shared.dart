// Shared animated builders for StatHighlightCard variants.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

Widget buildStatIcon(
  BuildContext context, {
  required IconData icon,
  required double size,
  required double padding,
  required Duration delay,
}) {
  final widget = Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: PRFColors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
    ),
    child: Icon(icon, size: size, color: PRFColors.white),
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate(delay: delay)
      .scale(duration: PRFMotionTokens.enterShort, curve: Curves.elasticOut)
      .fadeIn();
}

Widget buildStatTitle(
  BuildContext context, {
  required ThemeData theme,
  required String title,
  required Duration delay,
}) {
  final widget = Text(
    title,
    style: theme.textTheme.headlineSmall?.copyWith(
      color: PRFColors.white,
      fontWeight: FontWeight.w700,
    ),
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate(delay: delay)
      .fadeIn(duration: PRFMotionTokens.enterShort)
      .slideX(begin: -0.2, end: 0);
}

Widget buildStatSubtitle(
  BuildContext context, {
  required ThemeData theme,
  required String subtitle,
  required Duration delay,
}) {
  final widget = Text(
    subtitle,
    style: theme.textTheme.bodyMedium?.copyWith(
      color: PRFColors.white.withValues(alpha: 0.9),
    ),
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate(delay: delay)
      .fadeIn(duration: PRFMotionTokens.enterShort)
      .slideX(begin: -0.2, end: 0);
}
