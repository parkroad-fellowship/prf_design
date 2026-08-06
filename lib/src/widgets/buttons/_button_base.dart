import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/prf_button.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

/// Single shared button implementation used by [PRFButton]. Handles
/// press-scale feedback, loading state and semantics.
class PRFButtonBase extends StatefulWidget {
  const PRFButtonBase({
    required this.onPressed,
    required this.title,
    required this.variant,
    required this.disabled,
    required this.isLoading,
    required this.isTablet,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final PRFButtonVariant variant;
  final bool disabled;
  final bool isLoading;
  final bool isTablet;

  @override
  State<PRFButtonBase> createState() => _PRFButtonBaseState();
}

class _PRFButtonBaseState extends State<PRFButtonBase> {
  bool _pressed = false;

  bool get _isInteractive => !(widget.disabled || widget.isLoading);

  double get _height => widget.isTablet
      ? PRFButtonTokens.tabletHeight
      : PRFButtonTokens.handsetHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final button =
        widget.variant == PRFButtonVariant.secondary ||
            widget.variant == PRFButtonVariant.google
        ? OutlinedButton(
            onPressed: _isInteractive ? widget.onPressed : null,
            style: _style(theme),
            child: _label(theme),
          )
        : ElevatedButton(
            onPressed: _isInteractive ? widget.onPressed : null,
            style: _style(theme),
            child: _label(theme),
          );

    return Listener(
      onPointerDown: _isInteractive
          ? (_) => setState(() => _pressed = true)
          : null,
      onPointerUp: _isInteractive
          ? (_) => setState(() => _pressed = false)
          : null,
      onPointerCancel: _isInteractive
          ? (_) => setState(() => _pressed = false)
          : null,
      child: AnimatedScale(
        scale: _pressed ? PRFMotionTokens.pressedScale : 1,
        duration: PRFMotionTokens.resolve(context, PRFMotionTokens.fast),
        curve: PRFMotionTokens.emphasized,
        child: SizedBox(
          width: double.infinity,
          height: _height,
          child: button,
        ),
      ),
    );
  }

  ButtonStyle _style(ThemeData theme) {
    final scheme = theme.colorScheme;
    switch (widget.variant) {
      case PRFButtonVariant.primary:
        return _filledStyle(
          theme,
          background: scheme.primary,
          foreground: scheme.onPrimary,
        );
      case PRFButtonVariant.destructive:
        return _filledStyle(
          theme,
          background: scheme.error,
          foreground: scheme.onError,
        );
      case PRFButtonVariant.secondary:
        return _outlinedStyle(theme);
      case PRFButtonVariant.google:
        return _googleStyle(theme);
    }
  }

  ButtonStyle _filledStyle(
    ThemeData theme, {
    required Color background,
    required Color foreground,
  }) {
    return ButtonStyle(
      animationDuration: PRFMotionTokens.standard,
      minimumSize: WidgetStateProperty.all(Size(double.infinity, _height)),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: widget.isTablet
              ? PRFButtonTokens.tabletHorizontalPadding
              : PRFButtonTokens.handsetHorizontalPadding,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            widget.isTablet
                ? PRFButtonTokens.tabletRadius
                : PRFButtonTokens.handsetRadius,
          ),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return background.withValues(alpha: 0.42);
        }
        if (states.contains(WidgetState.pressed)) {
          return background.withValues(alpha: 0.92);
        }
        return background;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return foreground.withValues(alpha: 0.72);
        }
        return foreground;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return foreground.withValues(alpha: 0.14);
        }
        if (states.contains(WidgetState.hovered)) {
          return foreground.withValues(alpha: 0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return foreground.withValues(alpha: 0.12);
        }
        return null;
      }),
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return 0;
        if (states.contains(WidgetState.pressed)) {
          return PRFButtonTokens.elevationPressed;
        }
        if (states.contains(WidgetState.hovered)) {
          return PRFButtonTokens.elevationHover;
        }
        return PRFButtonTokens.elevationRest;
      }),
      shadowColor: WidgetStateProperty.all(theme.colorScheme.shadow),
      textStyle: WidgetStateProperty.all(_labelStyle(theme)),
    );
  }

  ButtonStyle _outlinedStyle(ThemeData theme) {
    final fg = theme.colorScheme.primary;
    return ButtonStyle(
      animationDuration: PRFMotionTokens.standard,
      minimumSize: WidgetStateProperty.all(Size(double.infinity, _height)),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: widget.isTablet
              ? PRFButtonTokens.tabletHorizontalPadding
              : PRFButtonTokens.handsetHorizontalPadding,
        ),
      ),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: fg.withValues(alpha: 0.36), width: 1.5);
        }
        if (states.contains(WidgetState.focused)) {
          return const BorderSide(width: 2);
        }
        return const BorderSide(width: 1.5);
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            widget.isTablet
                ? PRFButtonTokens.tabletRadius
                : PRFButtonTokens.handsetRadius,
          ),
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return fg.withValues(alpha: 0.4);
        }
        return fg;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return fg.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return fg.withValues(alpha: 0.06);
        }
        if (states.contains(WidgetState.focused)) {
          return fg.withValues(alpha: 0.1);
        }
        return null;
      }),
      elevation: WidgetStateProperty.all(0),
      textStyle: WidgetStateProperty.all(_labelStyle(theme)),
    );
  }

  ButtonStyle _googleStyle(ThemeData theme) {
    final scheme = theme.colorScheme;
    return _outlinedStyle(theme).copyWith(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        final color = scheme.onSurface;
        if (states.contains(WidgetState.disabled)) {
          return color.withValues(alpha: 0.4);
        }
        return color;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        final outline = scheme.outline;
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: outline.withValues(alpha: 0.5), width: 1.5);
        }
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: scheme.primary, width: 2);
        }
        return BorderSide(color: outline, width: 1.5);
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        final base = scheme.surface;
        if (states.contains(WidgetState.pressed)) {
          return base.withValues(alpha: 0.92);
        }
        return base;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return scheme.primary.withValues(alpha: 0.08);
        }
        if (states.contains(WidgetState.hovered)) {
          return scheme.primary.withValues(alpha: 0.05);
        }
        return null;
      }),
    );
  }

  TextStyle? _labelStyle(ThemeData theme) {
    final base = widget.isTablet
        ? theme.textTheme.titleLarge
        : theme.textTheme.titleMedium;
    return base?.copyWith(fontWeight: FontWeight.w600);
  }

  Color _loaderColor(ThemeData theme) {
    return switch (widget.variant) {
      PRFButtonVariant.primary => theme.colorScheme.onPrimary,
      PRFButtonVariant.secondary => theme.colorScheme.primary,
      PRFButtonVariant.destructive => theme.colorScheme.onError,
      PRFButtonVariant.google => theme.colorScheme.primary,
    };
  }

  Color _labelColor(ThemeData theme) {
    return switch (widget.variant) {
      PRFButtonVariant.primary => theme.colorScheme.onPrimary,
      PRFButtonVariant.secondary => theme.colorScheme.primary,
      PRFButtonVariant.destructive => theme.colorScheme.onError,
      PRFButtonVariant.google => theme.colorScheme.onSurface,
    };
  }

  Widget _label(ThemeData theme) {
    final loaderSize = widget.isTablet
        ? PRFButtonTokens.tabletLoaderSize
        : PRFButtonTokens.handsetLoaderSize;
    final loaderGap = widget.isTablet
        ? PRFButtonTokens.tabletLoaderGap
        : PRFButtonTokens.handsetLoaderGap;
    final semanticsLabel = widget.isLoading
        ? '${widget.title}, loading'
        : (widget.disabled ? '${widget.title}, disabled' : widget.title);

    return Semantics(
      label: semanticsLabel,
      container: true,
      excludeSemantics: true,
      button: true,
      enabled: _isInteractive,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.variant == PRFButtonVariant.google)
            SizedBox(
              width: loaderSize,
              height: loaderSize,
              child: widget.isLoading
                  ? PRFCircularProgressIndicator(color: _loaderColor(theme))
                  : SvgPicture.asset(
                      'assets/authentication/google_logo.svg',
                      package: 'prf_design',
                    ),
            ),
          if (widget.variant == PRFButtonVariant.google)
            const SizedBox(width: PRFButtonTokens.handsetLoaderGap),
          if (widget.isLoading &&
              widget.variant != PRFButtonVariant.google) ...[
            SizedBox(
              width: loaderSize,
              height: loaderSize,
              child: PRFCircularProgressIndicator(color: _loaderColor(theme)),
            ),
            SizedBox(width: loaderGap),
          ],
          Flexible(
            child: Text(
              widget.title,
              style: _labelStyle(theme)?.copyWith(color: _labelColor(theme)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
