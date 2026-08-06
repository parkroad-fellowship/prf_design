import 'package:flutter/material.dart';
import 'package:prf_design/src/enums/prf_failure.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/states/error_view/_handset.dart';
import 'package:prf_design/src/widgets/states/error_view/_tablet.dart';

/// A widget that displays an error state with an optional retry action.
///
/// Shows the [failure] message alongside an error icon. When [onRetry] is
/// provided a retry button is shown; [compact] renders a smaller inline
/// variant for embedding in lists or cards.
///
/// Example:
/// ```dart
/// PRFErrorView(
///   failure: PRFFailure.noConnection(),
///   onRetry: _reload,
/// )
///
/// // Or from a plain message:
/// PRFErrorView.fromMessage(message: 'Something went wrong', onRetry: _retry)
/// ```
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

  /// The error to display.
  final PRFFailure failure;

  /// Invoked when the retry button is pressed. When null no retry button is
  /// shown.
  final VoidCallback? onRetry;

  /// When true renders a smaller variant suited to inline/embedded layouts.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFErrorViewHandset(
        failure: failure,
        onRetry: onRetry,
        compact: compact,
      ),
      tablet: (_) => PRFErrorViewTablet(
        failure: failure,
        onRetry: onRetry,
        compact: compact,
      ),
      builder: (_, _) => PRFErrorViewTablet(
        failure: failure,
        onRetry: onRetry,
        compact: compact,
      ),
    );
  }
}
