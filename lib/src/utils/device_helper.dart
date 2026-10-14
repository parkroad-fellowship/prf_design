import 'package:flutter/material.dart' show BuildContext, MediaQuery;
import 'package:prf_design/src/theme/adaptive/prf_breakpoints.dart';

/// Device type enumeration
enum DeviceType { phone, tablet, desktop }

/// Device-related utilities.
class DeviceHelper {
  // Private constructor to prevent instantiation
  DeviceHelper._();

  /// Get scale factor based on device type and screen size
  static double getScaleFactor({
    BuildContext? context,
    double? customBaseWidth,
    double? minScale,
    double? maxScale,
  }) {
    final mediaQuery = context != null ? MediaQuery.maybeOf(context) : null;
    if (mediaQuery == null) {
      return 1;
    }

    final screenWidth = mediaQuery.size.width;
    final deviceType = getDeviceType(context: context);

    // Dynamic base widths based on device type
    final baseWidth =
        customBaseWidth ??
        switch (deviceType) {
          DeviceType.phone => 375.0,
          DeviceType.tablet => 600.0,
          DeviceType.desktop => 1200.0,
        };

    final scaleFactor = screenWidth / baseWidth;

    // Dynamic scale ranges based on device type. The phone floor is 0.92 so
    // the smallest theme style (labelSmall, 12sp base) never renders below
    // 11sp on narrow 320dp phones. The desktop floor equals the tablet
    // ceiling so text never shrinks as the screen widens (on these mobile
    // apps "desktop" is a large iPad in landscape).
    final minScaleValue =
        minScale ??
        switch (deviceType) {
          DeviceType.phone => 0.92,
          DeviceType.tablet => 0.7,
          DeviceType.desktop => 1.6,
        };

    final maxScaleValue =
        maxScale ??
        switch (deviceType) {
          DeviceType.phone => 1.4,
          DeviceType.tablet => 1.6,
          DeviceType.desktop => 2.0,
        };

    return scaleFactor.clamp(minScaleValue, maxScaleValue);
  }

  /// Get device type based on screen size, using the same [PRFBreakpoints]
  /// as `PRFAdaptive` so scaling and layout always agree.
  static DeviceType getDeviceType({BuildContext? context}) {
    final mediaQuery = context != null ? MediaQuery.maybeOf(context) : null;
    if (mediaQuery == null) {
      return DeviceType.phone;
    }
    final screenWidth = mediaQuery.size.width;

    return switch (PRFBreakpoints.fromWidth(screenWidth)) {
      PRFBreakpoint.desktop => DeviceType.desktop,
      PRFBreakpoint.tablet => DeviceType.tablet,
      PRFBreakpoint.handset => DeviceType.phone,
    };
  }

  /// Check if device is in landscape mode
  static bool isLandscape({BuildContext? context}) {
    final mediaQuery = context != null ? MediaQuery.maybeOf(context) : null;
    if (mediaQuery == null) {
      return false;
    }
    final size = mediaQuery.size;
    return size.width > size.height;
  }
}
