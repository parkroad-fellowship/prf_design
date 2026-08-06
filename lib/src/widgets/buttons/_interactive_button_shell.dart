import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Shared press-feedback shell used by button variants.
class PRFInteractiveButtonShell extends StatefulWidget {
  const PRFInteractiveButtonShell({
    required this.height,
    required this.enabled,
    required this.child,
    super.key,
  });

  final double height;
  final bool enabled;
  final Widget child;

  @override
  State<PRFInteractiveButtonShell> createState() =>
      _PRFInteractiveButtonShellState();
}

class _PRFInteractiveButtonShellState extends State<PRFInteractiveButtonShell> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: widget.enabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: widget.enabled
          ? () => setState(() => _pressed = false)
          : null,
      child: AnimatedScale(
        scale: _pressed ? PRFMotionTokens.pressedScale : 1,
        duration: PRFMotionTokens.resolve(context, PRFMotionTokens.fast),
        curve: PRFMotionTokens.emphasized,
        child: SizedBox(
          width: double.infinity,
          height: widget.height,
          child: widget.child,
        ),
      ),
    );
  }
}
