import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Themed linear progress bar, centred in its parent.
///
/// Example:
/// ```dart
/// PRFLinearProgressIndicator()
/// PRFLinearProgressIndicator(value: 0.6, borderRadius: 4)
/// ```
class PRFLinearProgressIndicator extends StatelessWidget {
  const PRFLinearProgressIndicator({
    super.key,
    this.color,
    this.value,
    this.height = PRFSizeTokens.progressBarHeight,
    this.borderRadius,
    this.backgroundColor,
  });

  /// Bar colour; defaults to the theme primary colour.
  final Color? color;

  /// Progress 0–1 for a determinate bar; null for indeterminate.
  final double? value;

  /// Bar thickness. Defaults to [PRFSizeTokens.progressBarHeight].
  final double height;

  /// Corner radius of the bar; null renders square corners.
  final double? borderRadius;

  /// Track colour behind the progress.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius != null
        ? BorderRadius.circular(borderRadius!)
        : BorderRadius.zero;
    return Semantics(
      label: 'Loading',
      child: Center(
        child: LinearProgressIndicator(
          value: value,
          minHeight: height,
          borderRadius: radius,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).colorScheme.primary,
          ),
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
