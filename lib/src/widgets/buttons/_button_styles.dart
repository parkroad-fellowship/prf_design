import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';

abstract final class PRFButtonStyles {
  static ButtonStyle primary(
    ThemeData theme, {
    required bool isTablet,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    final bg = backgroundColor ?? theme.colorScheme.primary;
    final fg = foregroundColor ?? theme.colorScheme.onPrimary;

    return ButtonStyle(
      animationDuration: PRFMotionTokens.standard,
      minimumSize: WidgetStateProperty.all(
        Size(
          double.infinity,
          isTablet ? PRFButtonTokens.tabletHeight : PRFButtonTokens.handsetHeight,
        ),
      ),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: isTablet
              ? PRFButtonTokens.tabletHorizontalPadding
              : PRFButtonTokens.handsetHorizontalPadding,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            isTablet ? PRFButtonTokens.tabletRadius : PRFButtonTokens.handsetRadius,
          ),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return bg.withValues(alpha: 0.42);
        }
        if (states.contains(WidgetState.pressed)) {
          return bg.withValues(alpha: 0.92);
        }
        return bg;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return fg.withValues(alpha: 0.72);
        }
        return fg;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return fg.withValues(alpha: 0.14);
        }
        if (states.contains(WidgetState.hovered)) {
          return fg.withValues(alpha: 0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return fg.withValues(alpha: 0.12);
        }
        return null;
      }),
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return 0;
        }
        if (states.contains(WidgetState.pressed)) {
          return PRFButtonTokens.elevationPressed;
        }
        if (states.contains(WidgetState.hovered)) {
          return PRFButtonTokens.elevationHover;
        }
        return PRFButtonTokens.elevationRest;
      }),
      shadowColor: WidgetStateProperty.all(theme.colorScheme.shadow),
      textStyle: WidgetStateProperty.all(
        (isTablet ? theme.textTheme.titleLarge : theme.textTheme.titleMedium)?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static ButtonStyle secondary(ThemeData theme, {required bool isTablet}) {
    final fg = theme.colorScheme.primary;
    return ButtonStyle(
      animationDuration: PRFMotionTokens.standard,
      minimumSize: WidgetStateProperty.all(
        Size(
          double.infinity,
          isTablet ? PRFButtonTokens.tabletHeight : PRFButtonTokens.handsetHeight,
        ),
      ),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: isTablet
              ? PRFButtonTokens.tabletHorizontalPadding
              : PRFButtonTokens.handsetHorizontalPadding,
        ),
      ),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: fg.withValues(alpha: 0.36), width: 1.5);
        }
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: fg, width: 2);
        }
        return BorderSide(color: fg, width: 1.5);
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            isTablet ? PRFButtonTokens.tabletRadius : PRFButtonTokens.handsetRadius,
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
      textStyle: WidgetStateProperty.all(
        (isTablet ? theme.textTheme.titleLarge : theme.textTheme.titleMedium)?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static ButtonStyle google(ThemeData theme, {required bool isTablet}) {
    return secondary(theme, isTablet: isTablet).copyWith(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        final color = theme.colorScheme.onSurface;
        if (states.contains(WidgetState.disabled)) {
          return color.withValues(alpha: 0.4);
        }
        return color;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        final outline = theme.colorScheme.outline;
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: outline.withValues(alpha: 0.5), width: 1.5);
        }
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: theme.colorScheme.primary, width: 2);
        }
        return BorderSide(color: outline, width: 1.5);
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        final base = theme.colorScheme.surface;
        if (states.contains(WidgetState.pressed)) {
          return base.withValues(alpha: 0.92);
        }
        return base;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return theme.colorScheme.primary.withValues(alpha: 0.08);
        }
        if (states.contains(WidgetState.hovered)) {
          return theme.colorScheme.primary.withValues(alpha: 0.05);
        }
        return null;
      }),
    );
  }
}
