// Shared pure builders and helpers for PRFErrorView variants.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/enums/prf_error_type.dart';
import 'package:prf_design/src/enums/prf_failure.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Resolved inputs shared by the PRFErrorView variants.
@immutable
class ErrorViewConfig {
  const ErrorViewConfig({
    required this.failure,
    required this.title,
    required this.retryLabel,
    required this.compact,
    this.onRetry,
  });

  final PRFFailure failure;
  final String title;
  final String retryLabel;
  final bool compact;

  /// Null when no retry should be offered (none given or not recoverable).
  final VoidCallback? onRetry;

  String get semanticLabel => 'Error: $title. ${failure.message}';
}

String errorTitle(PRFFailure failure) {
  switch (failure.type) {
    case PRFErrorType.network:
      return 'No internet connection';
    case PRFErrorType.authentication:
      return 'Please sign in again';
    case PRFErrorType.authorization:
      return "You don't have access";
    case PRFErrorType.validation:
      return 'Please check your details';
    case PRFErrorType.notFound:
      return "We couldn't find that";
    case PRFErrorType.server:
      return 'Something went wrong on our side';
    case PRFErrorType.timeout:
      return 'This is taking too long';
    case PRFErrorType.cancelled:
      return 'Action cancelled';
    case PRFErrorType.unknown:
      return 'Something went wrong';
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

Widget buildRetryButton(BuildContext context, {required Widget button}) {
  if (MediaQuery.of(context).disableAnimations) return button;
  return button
      .animate()
      .fadeIn(delay: PRFMotionTokens.stagger5)
      .scale(delay: PRFMotionTokens.stagger1);
}

/// Leading icon tile for the compact (inline) layout.
Widget buildCompactErrorIcon(
  BuildContext context, {
  required IconData icon,
  required double padding,
}) {
  final scheme = Theme.of(context).colorScheme;
  return Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: scheme.error.withValues(alpha: PRFOpacities.subtle),
      borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
    ),
    child: Icon(icon, size: PRFSizeTokens.iconLg, color: scheme.error),
  );
}

/// Title + message column for the compact (inline) layout.
Widget buildCompactErrorText(
  BuildContext context, {
  required String title,
  required String message,
  required TextStyle? titleStyle,
}) {
  final theme = Theme.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        title,
        style: titleStyle?.copyWith(color: theme.colorScheme.onSurface),
      ),
      const SizedBox(height: PRFSpacingTokens.xs),
      Text(
        message,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

/// Labelled, 48 dp retry button for the compact (inline) layout.
Widget buildCompactRetryButton(
  BuildContext context, {
  required VoidCallback onRetry,
  required String label,
}) {
  final scheme = Theme.of(context).colorScheme;
  return TextButton.icon(
    onPressed: onRetry,
    style: TextButton.styleFrom(
      foregroundColor: scheme.primary,
      minimumSize: const Size(
        PRFSizeTokens.minTouchTarget,
        PRFSizeTokens.minTouchTarget,
      ),
      tapTargetSize: MaterialTapTargetSize.padded,
      padding: const EdgeInsets.symmetric(horizontal: PRFSpacingTokens.md),
    ),
    icon: const Icon(Icons.refresh, size: PRFSizeTokens.iconMd),
    label: Text(label),
  );
}
