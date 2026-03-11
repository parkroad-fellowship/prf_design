import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/enums/prf_error_type.dart';
import 'package:prf_design/src/enums/prf_failure.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/primary/primary.dart';

/// A widget that displays an error state with an optional retry action.
class PRFErrorView extends StatelessWidget {
  const PRFErrorView({
    required this.failure,
    this.onRetry,
    this.compact = false,
    super.key,
  });

  /// Create an error view from a message string.
  factory PRFErrorView.fromMessage({
    required String message,
    VoidCallback? onRetry,
    bool compact = false,
    Key? key,
  }) {
    return PRFErrorView(
      failure: PRFFailure(message: message),
      onRetry: onRetry,
      compact: compact,
      key: key,
    );
  }

  /// Create an error view from a PRFFailure.
  factory PRFErrorView.fromFailure({
    required PRFFailure failure,
    VoidCallback? onRetry,
    bool compact = false,
    Key? key,
  }) {
    return PRFErrorView(
      failure: failure,
      onRetry: onRetry,
      compact: compact,
      key: key,
    );
  }

  final PRFFailure failure;
  final VoidCallback? onRetry;
  final bool compact;

  IconData get _icon {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (compact) {
      return Semantics(
        label: 'Error: ${_getTitle()}. ${failure.message}',
        liveRegion: true,
        child: _buildCompact(theme),
      );
    }

    return Semantics(
      label: 'Error: ${_getTitle()}. ${failure.message}',
      liveRegion: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _icon,
                  size: 48,
                  color: theme.colorScheme.error,
                ),
              ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
              const SizedBox(height: 16),
              Text(
                _getTitle(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 8),
              Text(
                failure.message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
              if (failure.isRecoverable && onRetry != null) ...[
                const SizedBox(height: 24),
                PRFPrimaryButton(
                  onPressed: onRetry!,
                  title: 'Try Again',
                  disabled: false,
                ).animate().fadeIn(delay: 500.ms).scale(delay: 100.ms),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompact(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
            ),
            child: Icon(
              _icon,
              size: 24,
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getTitle(),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  failure.message,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (failure.isRecoverable && onRetry != null)
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              color: theme.colorScheme.primary,
            ),
        ],
      ),
    );
  }

  String _getTitle() {
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
}
