import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class PRFSecondaryButtonTablet extends StatefulWidget {
  const PRFSecondaryButtonTablet({
    required this.onPressed,
    required this.title,
    required this.disabled,
    super.key,
    this.isLoading,
  });

  final VoidCallback onPressed;
  final String title;
  final bool disabled;
  final bool? isLoading;

  @override
  State<PRFSecondaryButtonTablet> createState() =>
      _PRFSecondaryButtonTabletState();
}

class _PRFSecondaryButtonTabletState extends State<PRFSecondaryButtonTablet> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isInteractive = !(widget.disabled || (widget.isLoading ?? false));

    return GestureDetector(
      onTapDown: isInteractive ? (_) => setState(() => _pressed = true) : null,
      onTapUp: isInteractive ? (_) => setState(() => _pressed = false) : null,
      onTapCancel:
          isInteractive ? () => setState(() => _pressed = false) : null,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: PRFMotionTokens.fast,
        curve: PRFMotionTokens.emphasized,
        child: SizedBox(
          width: double.infinity,
          height: PRFButtonTokens.tabletHeight,
          child: OutlinedButton(
            onPressed: (widget.disabled || (widget.isLoading ?? false))
                ? null
                : widget.onPressed,
            style: PRFButtonStyles.secondary(theme, isTablet: true),
            child: Semantics(
              label: (widget.isLoading ?? false)
                  ? '${widget.title}, loading'
                  : (widget.disabled
                      ? '${widget.title}, disabled'
                      : widget.title),
              button: true,
              enabled: !(widget.disabled || (widget.isLoading ?? false)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading ?? false) ...[
                    SizedBox(
                      height: PRFButtonTokens.tabletLoaderSize,
                      width: PRFButtonTokens.tabletLoaderSize,
                      child: PRFCircularProgressIndicator(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: PRFButtonTokens.tabletLoaderGap),
                  ],
                  Text(
                    widget.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
