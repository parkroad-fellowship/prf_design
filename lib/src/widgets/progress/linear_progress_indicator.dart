import 'package:flutter/material.dart';

class PRFLinearProgressIndicator extends StatelessWidget {
  const PRFLinearProgressIndicator({
    super.key,
    this.color,
    this.value,
    this.height = 4,
    this.borderRadius,
    this.backgroundColor,
  });

  final Color? color;
  final double? value;
  final double height;
  final double? borderRadius;
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
