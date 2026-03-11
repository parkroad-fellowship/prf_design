import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class PRFGoogleAuthButtonHandset extends StatefulWidget {
  const PRFGoogleAuthButtonHandset({
    required this.onPressed,
    required this.title,
    required this.disabled,
    super.key,
    this.isLoading,
    this.googleLogoAsset,
  });

  final VoidCallback onPressed;
  final String title;
  final bool disabled;
  final bool? isLoading;
  final Widget? googleLogoAsset;

  @override
  State<PRFGoogleAuthButtonHandset> createState() =>
      _PRFGoogleAuthButtonHandsetState();
}

class _PRFGoogleAuthButtonHandsetState
    extends State<PRFGoogleAuthButtonHandset> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isInteractive = !(widget.disabled || (widget.isLoading ?? false));

    return GestureDetector(
      onTapDown: isInteractive ? (_) => setState(() => _pressed = true) : null,
      onTapUp: isInteractive ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: isInteractive
          ? () => setState(() => _pressed = false)
          : null,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: PRFMotionTokens.fast,
        curve: PRFMotionTokens.emphasized,
        child: SizedBox(
          width: double.infinity,
          height: PRFButtonTokens.handsetHeight,
          child: OutlinedButton(
            onPressed: (widget.disabled || (widget.isLoading ?? false))
                ? null
                : widget.onPressed,
            style: PRFButtonStyles.google(theme, isTablet: false),
            child: Semantics(
              label: (widget.isLoading ?? false)
                  ? '${widget.title}, loading'
                  : (widget.disabled
                        ? '${widget.title}, disabled'
                        : widget.title),
              container: true,
              excludeSemantics: true,
              button: true,
              enabled: !(widget.disabled || (widget.isLoading ?? false)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading ?? false)
                    SizedBox(
                      height: PRFButtonTokens.handsetLoaderSize,
                      width: PRFButtonTokens.handsetLoaderSize,
                      child: PRFCircularProgressIndicator(
                        color: theme.colorScheme.primary,
                      ),
                    )
                  else if (widget.googleLogoAsset != null)
                    SizedBox(
                      height: PRFButtonTokens.handsetLoaderSize,
                      width: PRFButtonTokens.handsetLoaderSize,
                      child: widget.googleLogoAsset,
                    )
                  else
                    const SizedBox(
                      width: PRFButtonTokens.handsetLoaderSize,
                      height: PRFButtonTokens.handsetLoaderSize,
                    ),
                  const SizedBox(width: PRFButtonTokens.handsetLoaderGap),
                  Flexible(
                    child: Text(
                      widget.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
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
