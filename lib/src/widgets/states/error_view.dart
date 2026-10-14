import 'package:flutter/material.dart';
import 'package:prf_design/src/enums/prf_failure.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/states/error_view/_handset.dart';
import 'package:prf_design/src/widgets/states/error_view/_shared.dart';
import 'package:prf_design/src/widgets/states/error_view/_tablet.dart';

/// Default plain-language title for [PRFErrorView.inline].
const String kPRFErrorDefaultTitle = 'Something went wrong';

/// Default plain-language description for [PRFErrorView.inline].
const String kPRFErrorDefaultMessage = 'Check your connection and try again.';

/// Default label for the retry button.
const String kPRFErrorDefaultRetryLabel = 'Try again';

/// A widget that displays an error state with an optional retry action.
///
/// Shows a plain-language title (derived from the [failure] type unless
/// [title] is given), the [failure] message and an error icon. When [onRetry]
/// is provided and the failure is recoverable, a clearly labelled retry
/// button ([retryLabel], "Try again" by default) is shown.
///
/// [compact] (or the [PRFErrorView.inline] constructor) renders a smaller
/// inline variant for use inside lists, cards and sections instead of a
/// full-screen state.
///
/// Example:
/// ```dart
/// PRFErrorView(
///   failure: PRFFailure.noConnection(),
///   onRetry: _reload,
/// )
///
/// // Or from a plain message:
/// PRFErrorView.fromMessage(
///   message: 'Could not load missions',
///   onRetry: _retry,
/// )
///
/// // Inline, inside a section, with friendly defaults:
/// PRFErrorView.inline(onRetry: _reloadSection)
/// ```
class PRFErrorView extends StatelessWidget {
  const PRFErrorView({
    required this.failure,
    this.onRetry,
    this.compact = false,
    this.title,
    this.retryLabel = kPRFErrorDefaultRetryLabel,
    super.key,
  });

  /// Inline error for embedding in lists and sections.
  ///
  /// Defaults to the title "Something went wrong" and the message
  /// "Check your connection and try again." — pass localised strings to
  /// override. Always shows the retry button when [onRetry] is set.
  PRFErrorView.inline({
    String this.title = kPRFErrorDefaultTitle,
    String message = kPRFErrorDefaultMessage,
    this.onRetry,
    this.retryLabel = kPRFErrorDefaultRetryLabel,
    super.key,
  }) : failure = PRFFailure(message: message),
       compact = true;

  /// Create an error view from a message string.
  factory PRFErrorView.fromMessage({
    required String message,
    VoidCallback? onRetry,
    bool compact = false,
    String? title,
    String retryLabel = kPRFErrorDefaultRetryLabel,
    Key? key,
  }) {
    return PRFErrorView(
      failure: PRFFailure(message: message),
      onRetry: onRetry,
      compact: compact,
      title: title,
      retryLabel: retryLabel,
      key: key,
    );
  }

  /// Create an error view from a PRFFailure.
  factory PRFErrorView.fromFailure({
    required PRFFailure failure,
    VoidCallback? onRetry,
    bool compact = false,
    String? title,
    String retryLabel = kPRFErrorDefaultRetryLabel,
    Key? key,
  }) {
    return PRFErrorView(
      failure: failure,
      onRetry: onRetry,
      compact: compact,
      title: title,
      retryLabel: retryLabel,
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

  /// Overrides the title derived from the failure type.
  final String? title;

  /// Text on the retry button. Defaults to "Try again".
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final config = ErrorViewConfig(
      failure: failure,
      title: title ?? errorTitle(failure),
      onRetry: failure.isRecoverable ? onRetry : null,
      retryLabel: retryLabel,
      compact: compact,
    );
    return PRFAdaptive(
      handset: (_) => PRFErrorViewHandset(config: config),
      tablet: (_) => PRFErrorViewTablet(config: config),
      builder: (_, _) => PRFErrorViewTablet(config: config),
    );
  }
}
