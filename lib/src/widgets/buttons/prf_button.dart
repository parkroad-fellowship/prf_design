import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/buttons/_button_base.dart';

/// Button variants available on [PRFButton].
enum PRFButtonVariant {
  /// Filled navy primary action.
  primary,

  /// Filled lime green secondary action.
  secondary,

  /// Filled error-coloured destructive action.
  destructive,

  /// Outlined action with the Google logo.
  google,
}

/// Adaptive button with a single implementation across device sizes.
///
/// Renders full-width on handset and width-constrained on tablet. A
/// press-scale animation provides feedback and a loader replaces the label
/// while [isLoading] is true. The visual style is chosen with [variant].
///
/// Example:
/// ```dart
/// PRFButton(
///   onPressed: _continue,
///   title: 'Continue',
///   variant: PRFButtonVariant.primary,
///   disabled: false,
///   isLoading: _submitting,
/// )
/// ```
class PRFButton extends StatelessWidget {
  const PRFButton({
    required this.onPressed,
    required this.title,
    this.variant = PRFButtonVariant.primary,
    this.disabled = false,
    this.isLoading = false,
    super.key,
  });

  /// Invoked when the button is tapped and it is not disabled/loading.
  final VoidCallback onPressed;

  /// Button label.
  final String title;

  /// Visual treatment of the button. Defaults to [PRFButtonVariant.primary].
  final PRFButtonVariant variant;

  /// When true the button is non-interactive and dimmed.
  final bool disabled;

  /// When true a spinner replaces the label and taps are ignored.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFButtonBase(
        onPressed: onPressed,
        title: title,
        variant: variant,
        disabled: disabled,
        isLoading: isLoading,
        isTablet: false,
      ),
      tablet: (_) => PRFButtonBase(
        onPressed: onPressed,
        title: title,
        variant: variant,
        disabled: disabled,
        isLoading: isLoading,
        isTablet: true,
      ),
      builder: (_, _) => PRFButtonBase(
        onPressed: onPressed,
        title: title,
        variant: variant,
        disabled: disabled,
        isLoading: isLoading,
        isTablet: true,
      ),
    );
  }
}
