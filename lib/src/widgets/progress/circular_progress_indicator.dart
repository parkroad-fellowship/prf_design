import 'package:flutter/material.dart';

class PRFCircularProgressIndicator extends StatelessWidget {
  const PRFCircularProgressIndicator({
    super.key,
    this.color,
    this.value,
    this.size = 24,
    this.strokeWidth = 2,
  });

  final Color? color;
  final double? value;
  final double size;
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
