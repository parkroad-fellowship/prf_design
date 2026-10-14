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
    this.icon,
    this.fullWidth = true,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final PRFButtonVariant variant;
  final bool disabled;
  final bool isLoading;
  final bool isTablet;
  final IconData? icon;
  final bool fullWidth;

  @override
  State<PRFButtonBase> createState() => _PRFButtonBaseState();
}

class _PRFButtonBaseState extends State<PRFButtonBase> {
  bool _pressed = false;

  bool get _isInteractive => !(widget.disabled || widget.isLoading);

  double get _height => widget.isTablet
      ? PRFButtonTokens.tabletHeight
      : PRFButtonTokens.handsetHeight;

  Size get _minimumSize => widget.fullWidth
      ? Size(double.infinity, _height)
      : const Size.square(PRFSizeTokens.minTouchTarget);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onPressed = _isInteractive ? widget.onPressed : null;
    final style = _style(theme);
    final label = _label(theme);
    final button = switch (widget.variant) {
      PRFButtonVariant.google || PRFButtonVariant.outlined => OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: label,
      ),
      PRFButtonVariant.text => TextButton(
        onPressed: onPressed,
        style: style,
        child: label,
      ),
      _ => ElevatedButton(onPressed: onPressed, style: style, child: label),
    };

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
        // Min height, not fixed height: the label may wrap or grow with the
        // system text scale, and the button grows with it.
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: widget.fullWidth
                ? double.infinity
                : PRFSizeTokens.minTouchTarget,
            minHeight: widget.fullWidth
                ? _height
                : PRFSizeTokens.minTouchTarget,
          ),
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
      case PRFButtonVariant.secondary:
        return _filledStyle(
          theme,
          background: scheme.secondary,
          foreground: scheme.onSecondary,
        );
      case PRFButtonVariant.destructive:
        return _filledStyle(
          theme,
          background: scheme.error,
          foreground: scheme.onError,
        );
      case PRFButtonVariant.google:
        return _googleStyle(theme);
      case PRFButtonVariant.outlined:
        return _outlinedStyle(theme);
      case PRFButtonVariant.text:
        return _outlinedStyle(
          theme,
        ).copyWith(side: WidgetStateProperty.all(BorderSide.none));
    }
  }

  ButtonStyle _filledStyle(
    ThemeData theme, {
    required Color background,
    required Color foreground,
  }) {
    return ButtonStyle(
      animationDuration: PRFMotionTokens.resolve(
        context,
        PRFMotionTokens.standard,
      ),
      minimumSize: WidgetStateProperty.all(_minimumSize),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: widget.isTablet
              ? PRFButtonTokens.tabletHorizontalPadding
              : PRFButtonTokens.handsetHorizontalPadding,
          vertical: PRFSpacingTokens.sm,
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
          return background.withValues(alpha: PRFOpacities.accent);
        }
        if (states.contains(WidgetState.pressed)) {
          return background.withValues(alpha: PRFOpacities.nearOpaque);
        }
        return background;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return foreground.withValues(alpha: PRFOpacities.high);
        }
        return foreground;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return foreground.withValues(alpha: PRFOpacities.hairline);
        }
        if (states.contains(WidgetState.hovered)) {
          return foreground.withValues(alpha: PRFOpacities.subtle);
        }
        if (states.contains(WidgetState.focused)) {
          return foreground.withValues(alpha: PRFOpacities.hairline);
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
      animationDuration: PRFMotionTokens.resolve(
        context,
        PRFMotionTokens.standard,
      ),
      minimumSize: WidgetStateProperty.all(_minimumSize),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: widget.isTablet
              ? PRFButtonTokens.tabletHorizontalPadding
              : PRFButtonTokens.handsetHorizontalPadding,
          vertical: PRFSpacingTokens.sm,
        ),
      ),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: fg.withValues(alpha: PRFOpacities.accent),
            width: 1.5,
          );
        }
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: fg, width: 2);
        }
        return BorderSide(color: fg, width: 1.5);
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
          return fg.withValues(alpha: PRFOpacities.accent);
        }
        return fg;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return fg.withValues(alpha: PRFOpacities.hairline);
        }
        if (states.contains(WidgetState.hovered)) {
          return fg.withValues(alpha: PRFOpacities.faint);
        }
        if (states.contains(WidgetState.focused)) {
          return fg.withValues(alpha: PRFOpacities.subtle);
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
          return color.withValues(alpha: PRFOpacities.accent);
        }
        return color;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        final outline = scheme.outline;
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: outline.withValues(alpha: PRFOpacities.half),
            width: 1.5,
          );
        }
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: scheme.primary, width: 2);
        }
        return BorderSide(color: outline, width: 1.5);
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        final base = scheme.surface;
        if (states.contains(WidgetState.pressed)) {
          return base.withValues(alpha: PRFOpacities.nearOpaque);
        }
        return base;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return scheme.primary.withValues(alpha: PRFOpacities.subtle);
        }
        if (states.contains(WidgetState.hovered)) {
          return scheme.primary.withValues(alpha: PRFOpacities.faint);
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
      PRFButtonVariant.secondary => theme.colorScheme.onSecondary,
      PRFButtonVariant.destructive => theme.colorScheme.onError,
      PRFButtonVariant.google ||
      PRFButtonVariant.outlined ||
      PRFButtonVariant.text => theme.colorScheme.primary,
    };
  }

  Color _labelColor(ThemeData theme) {
    return switch (widget.variant) {
      PRFButtonVariant.primary => theme.colorScheme.onPrimary,
      PRFButtonVariant.secondary => theme.colorScheme.onSecondary,
      PRFButtonVariant.destructive => theme.colorScheme.onError,
      PRFButtonVariant.google => theme.colorScheme.onSurface,
      PRFButtonVariant.outlined ||
      PRFButtonVariant.text => theme.colorScheme.primary,
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

    // Not a container: the label merges into the Material button's own
    // semantics node, so the tappable node is the labelled one.
    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
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
          ] else if (widget.icon != null &&
              widget.variant != PRFButtonVariant.google) ...[
            Icon(
              widget.icon,
              size: PRFSizeTokens.iconMd,
              color: _labelColor(theme),
            ),
            SizedBox(width: loaderGap),
          ],
          Flexible(
            child: Text(
              widget.title,
              style: _labelStyle(theme)?.copyWith(color: _labelColor(theme)),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
