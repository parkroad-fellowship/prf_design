// Shared pure builders for PRFEmptyView handset and tablet variants.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

Widget buildEmptyIcon(
  BuildContext context, {
  required ThemeData theme,
  required IconData icon,
  required double size,
  required double containerPadding,
}) {
  final widget = Container(
    padding: EdgeInsets.all(containerPadding),
    decoration: BoxDecoration(
      color: theme.colorScheme.primary.withValues(alpha: 0.1),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: size, color: theme.colorScheme.primary),
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate()
      .fadeIn(duration: PRFMotionTokens.enterShort)
      .scale(delay: PRFMotionTokens.stagger2);
}

Widget buildEmptyLabel(
  BuildContext context, {
  required ThemeData theme,
  required String label,
}) {
  final widget = Text(
    label,
    style: theme.textTheme.headlineSmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    ),
    textAlign: TextAlign.center,
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate()
      .fadeIn(delay: PRFMotionTokens.stagger3)
      .slideY(begin: 0.3, end: 0);
}

Widget buildEmptyDescription(
  BuildContext context, {
  required ThemeData theme,
  required String description,
}) {
  final widget = Text(
    description,
    style: theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
    ),
    textAlign: TextAlign.center,
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate()
      .fadeIn(delay: PRFMotionTokens.stagger4)
      .slideY(begin: 0.3, end: 0);
}

Widget buildEmptyAction(
  BuildContext context, {
  required Widget? action,
  Widget? actionButton,
}) {
  assert(
    action != null || actionButton != null,
    'Provide either an action widget or an actionButton.',
  );
  final widget = action ?? actionButton!;
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate()
      .fadeIn(delay: PRFMotionTokens.stagger5)
      .scale(delay: PRFMotionTokens.stagger1);
}
