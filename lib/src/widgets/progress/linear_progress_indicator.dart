import 'package:flutter/material.dart';

class PRFLinearProgressIndicator extends StatelessWidget {
  const PRFLinearProgressIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading',
      child: Center(
        child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
