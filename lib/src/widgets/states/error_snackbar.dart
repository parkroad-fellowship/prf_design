import 'package:flutter/material.dart';
import 'package:prf_design/src/enums/prf_error_severity.dart';
import 'package:prf_design/src/enums/prf_error_type.dart';
import 'package:prf_design/src/enums/prf_failure.dart';

/// Helper class for showing error snackbars.
class PRFErrorSnackbar {
  // Private constructor to prevent instantiation
  PRFErrorSnackbar._();

  /// Show an error snackbar from a PRFFailure.
  static void show(
    BuildContext context,
    PRFFailure failure, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    final theme = Theme.of(context);
    final messenger = ScaffoldMessenger.of(context)
      // Clear any existing snackbars
      ..clearSnackBars();

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            _getIcon(failure.type),
            color: _getIconColor(theme, failure.severity),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              failure.message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onInverseSurface,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: _getBackgroundColor(theme, failure.severity),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      action: failure.isRecoverable && onRetry != null
          ? SnackBarAction(
              label: 'Retry',
              textColor: theme.colorScheme.inversePrimary,
              onPressed: () {
                messenger.hideCurrentSnackBar();
                onRetry();
              },
            )
          : null,
    );

    messenger.showSnackBar(snackBar);
  }

  /// Show an error snackbar from a message string.
  static void showMessage(
    BuildContext context,
    String message, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      PRFFailure(message: message),
      onRetry: onRetry,
      duration: duration,
    );
  }

  static IconData _getIcon(PRFErrorType type) {
    switch (type) {
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

  static Color _getBackgroundColor(ThemeData theme, PRFErrorSeverity severity) {
    switch (severity) {
      case PRFErrorSeverity.low:
        return theme.colorScheme.surfaceContainerHighest;
      case PRFErrorSeverity.medium:
        return theme.colorScheme.inverseSurface;
      case PRFErrorSeverity.high:
        return theme.colorScheme.errorContainer;
      case PRFErrorSeverity.critical:
        return theme.colorScheme.error;
    }
  }

  static Color _getIconColor(ThemeData theme, PRFErrorSeverity severity) {
    switch (severity) {
      case PRFErrorSeverity.low:
        return theme.colorScheme.onSurfaceVariant;
      case PRFErrorSeverity.medium:
        return theme.colorScheme.onInverseSurface;
      case PRFErrorSeverity.high:
        return theme.colorScheme.onErrorContainer;
      case PRFErrorSeverity.critical:
        return theme.colorScheme.onError;
    }
  }
}
