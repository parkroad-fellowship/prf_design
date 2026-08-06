import 'package:flutter/material.dart';

/// Themed circular progress spinner, centred in its parent.
///
/// Example:
/// ```dart
/// PRFCircularProgressIndicator()
/// PRFCircularProgressIndicator(size: 32, strokeWidth: 3)
/// PRFCircularProgressIndicator(value: 0.5) // determinate
/// ```
class PRFCircularProgressIndicator extends StatelessWidget {
  const PRFCircularProgressIndicator({
    super.key,
    this.color,
    this.value,
    this.size = 24,
    this.strokeWidth = 2,
  });

  /// Spinner colour; defaults to the theme primary colour.
  final Color? color;

  /// Progress 0–1 for a determinate indicator; null for indeterminate.
  final double? value;

  /// Diameter of the spinner in logical pixels. Defaults to 24.
  final double size;

  /// Thickness of the spinner arc. Defaults to 2.
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading',
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
