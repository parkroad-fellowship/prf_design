// Shared pure builders and helpers for PRFErrorView variants.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/enums/prf_error_type.dart';
import 'package:prf_design/src/enums/prf_failure.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

String errorTitle(PRFFailure failure) {
  switch (failure.type) {
    case PRFErrorType.network:
      return 'Connection Error';
    case PRFErrorType.authentication:
      return 'Authentication Required';
    case PRFErrorType.authorization:
      return 'Access Denied';
    case PRFErrorType.validation:
      return 'Invalid Input';
    case PRFErrorType.notFound:
      return 'Not Found';
    case PRFErrorType.server:
      return 'Server Error';
    case PRFErrorType.timeout:
      return 'Request Timeout';
    case PRFErrorType.cancelled:
      return 'Request Cancelled';
    case PRFErrorType.unknown:
      return 'Something Went Wrong';
  }
}

IconData errorIcon(PRFFailure failure) {
  switch (failure.type) {
    case PRFErrorType.network:
      return Icons.wifi_off_outlined;
    case PRFErrorType.authentication:
      return Icons.lock_outline;
    case PRFErrorType.authorization:
      return Icons.block_outlined;
    case PRFErrorType.validation:
      return Icons.warning_amber_outlined;
    case PRFErrorType.notFound:
      return Icons.search_off_outlined;
    case PRFErrorType.server:
      return Icons.cloud_off_outlined;
    case PRFErrorType.timeout:
      return Icons.timer_off_outlined;
    case PRFErrorType.cancelled:
      return Icons.cancel_outlined;
    case PRFErrorType.unknown:
      return Icons.error_outline;
  }
}

Widget buildErrorIcon(
  BuildContext context, {
  required ThemeData theme,
  required IconData icon,
  required double size,
  required double containerPadding,
}) {
  final widget = Container(
    padding: EdgeInsets.all(containerPadding),
    decoration: BoxDecoration(
      color: theme.colorScheme.error.withValues(alpha: 0.1),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: size, color: theme.colorScheme.error),
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate()
      .fadeIn(duration: PRFMotionTokens.enterShort)
      .scale(delay: PRFMotionTokens.stagger2);
}

Widget buildErrorTitle(
  BuildContext context, {
  required ThemeData theme,
  required String title,
}) {
  final widget = Text(
    title,
    style: theme.textTheme.headlineSmall?.copyWith(
      color: theme.colorScheme.onSurface,
    ),
    textAlign: TextAlign.center,
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate()
      .fadeIn(delay: PRFMotionTokens.stagger3)
      .slideY(begin: 0.3, end: 0);
}

Widget buildErrorMessage(
  BuildContext context, {
  required ThemeData theme,
  required String message,
}) {
  final widget = Text(
    message,
    style: theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    ),
    textAlign: TextAlign.center,
  );
  if (MediaQuery.of(context).disableAnimations) return widget;
  return widget
      .animate()
      .fadeIn(delay: PRFMotionTokens.stagger4)
      .slideY(begin: 0.3, end: 0);
}

Widget buildRetryButton(
  BuildContext context, {
  required Widget button,
}) {
  if (MediaQuery.of(context).disableAnimations) return button;
  return button
      .animate()
      .fadeIn(delay: PRFMotionTokens.stagger5)
      .scale(delay: PRFMotionTokens.stagger1);
}
