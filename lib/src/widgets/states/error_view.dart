import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/enums/prf_failure.dart';
import 'package:prf_design/src/widgets/states/error_view/_handset.dart';
import 'package:prf_design/src/widgets/states/error_view/_tablet.dart';

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

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFErrorViewTablet(
        failure: failure,
        onRetry: onRetry,
        compact: compact,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFErrorViewHandset(
          failure: failure,
          onRetry: onRetry,
          compact: compact,
        ),
        tablet: (_, _) => PRFErrorViewTablet(
          failure: failure,
          onRetry: onRetry,
          compact: compact,
        ),
      ),
    );
  }
}
