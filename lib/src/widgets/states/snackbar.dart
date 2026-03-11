import 'package:flutter/material.dart';
import 'package:prf_design/src/enums/prf_snackbar_type.dart';
import 'package:prf_design/src/theme/extensions/theme_context_extensions.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Unified snackbar helper with typed variants (error, success, info, warning).
class PRFSnackbar {
  PRFSnackbar._();

  /// Show an **error** snackbar (red, error icon, optional Retry action).
  static void error(
    BuildContext context,
    String message, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) => _show(
    context,
    message,
    type: PRFSnackbarType.error,
    onRetry: onRetry,
    duration: duration,
  );

  /// Show a **success** snackbar (green, check icon).
  static void success(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) => _show(
    context,
    message,
    type: PRFSnackbarType.success,
    duration: duration,
  );

  /// Show an **info** snackbar (blue, info icon).
  static void info(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) => _show(context, message, type: PRFSnackbarType.info, duration: duration);

  /// Show a **warning** snackbar (amber, warning icon).
  static void warning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) => _show(
    context,
    message,
    type: PRFSnackbarType.warning,
    duration: duration,
  );

  // ── private ──────────────────────────────────────────────────────────

  static void _show(
    BuildContext context,
    String message, {
    required PRFSnackbarType type,
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    final statusColors = context.statusColors;
    final colors = switch (type) {
      PRFSnackbarType.error => statusColors.error,
      PRFSnackbarType.success => statusColors.success,
      PRFSnackbarType.info => statusColors.info,
      PRFSnackbarType.warning => statusColors.warning,
    };

    final icon = switch (type) {
      PRFSnackbarType.error => Icons.error_outline,
      PRFSnackbarType.success => Icons.check_circle_outline,
      PRFSnackbarType.info => Icons.info_outline,
      PRFSnackbarType.warning => Icons.warning_amber_outlined,
    };

    final messenger = ScaffoldMessenger.of(context)..clearSnackBars();

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: colors.onColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.onColor,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colors.main,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PRFRadiusTokens.sm)),
      action: onRetry != null
          ? SnackBarAction(
              label: 'Retry',
              textColor: colors.onColor,
              onPressed: () {
                messenger.hideCurrentSnackBar();
                onRetry();
              },
            )
          : null,
    );

    messenger.showSnackBar(snackBar);
  }
}
