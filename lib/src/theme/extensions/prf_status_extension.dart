import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/_index.dart';

/// Represents a complete status color set with main, background & text colors.
@immutable
class StatusColorSet {
  const StatusColorSet({
    required this.main,
    required this.background,
    required this.onColor,
  });

  factory StatusColorSet.lerp(
    StatusColorSet a,
    StatusColorSet b,
    double t,
  ) {
    return StatusColorSet(
      main: Color.lerp(a.main, b.main, t)!,
      background: Color.lerp(a.background, b.background, t)!,
      onColor: Color.lerp(a.onColor, b.onColor, t)!,
    );
  }

  /// The main/primary color for the status
  final Color main;

  /// Light background color for containers/cards
  final Color background;

  /// Text/icon color to use on the main color
  final Color onColor;

  StatusColorSet copyWith({
    Color? main,
    Color? background,
    Color? onColor,
  }) {
    return StatusColorSet(
      main: main ?? this.main,
      background: background ?? this.background,
      onColor: onColor ?? this.onColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusColorSet &&
          runtimeType == other.runtimeType &&
          main == other.main &&
          background == other.background &&
          onColor == other.onColor;

  @override
  int get hashCode => Object.hash(main, background, onColor);
}

/// ThemeExtension providing semantic status colors.
///
/// Access via BuildContext:
/// ```dart
/// final status = Theme.of(context).extension<PRFStatusExtension>()!;
/// // or with convenience extension:
/// final status = context.statusColors;
/// ```
@immutable
class PRFStatusExtension extends ThemeExtension<PRFStatusExtension> {
  const PRFStatusExtension({
    // Status color sets
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    // Mission/task statuses
    required this.pending,
    required this.initiated,
    required this.scheduled,
    required this.inProgress,
    required this.completed,
    required this.failed,
    required this.ignored,
    // Active indicator
    required this.active,
    required this.activeGlow,
  });

  // Standard status colors
  final StatusColorSet success;
  final StatusColorSet warning;
  final StatusColorSet error;
  final StatusColorSet info;

  // Mission/task status colors
  final StatusColorSet pending;
  final StatusColorSet initiated;
  final StatusColorSet scheduled;
  final StatusColorSet inProgress;
  final StatusColorSet completed;
  final StatusColorSet failed;
  final StatusColorSet ignored;

  // Active/ongoing indicator colors
  final Color active;
  final Color activeGlow;

  /// Light theme instance
  static const light = PRFStatusExtension(
    // Standard statuses
    success: StatusColorSet(
      main: PRFColors.success,
      background: PRFColors.successLight,
      onColor: PRFColors.white,
    ),
    warning: StatusColorSet(
      main: PRFColors.warning,
      background: PRFColors.warningLight,
      onColor: PRFColors.black,
    ),
    error: StatusColorSet(
      main: PRFColors.error,
      background: PRFColors.errorLight,
      onColor: PRFColors.white,
    ),
    info: StatusColorSet(
      main: PRFColors.info,
      background: PRFColors.infoLight,
      onColor: PRFColors.white,
    ),
    // Mission statuses
    pending: StatusColorSet(
      main: PRFColors.orange,
      background: Color(0xFFFFF7ED), // orange-50
      onColor: PRFColors.white,
    ),
    initiated: StatusColorSet(
      main: PRFColors.blue,
      background: Color(0xFFEFF6FF), // blue-50
      onColor: PRFColors.white,
    ),
    scheduled: StatusColorSet(
      main: PRFColors.orange,
      background: Color(0xFFFFF7ED), // orange-50
      onColor: PRFColors.white,
    ),
    inProgress: StatusColorSet(
      main: PRFColors.emerald,
      background: Color(0xFFECFDF5), // emerald-50
      onColor: PRFColors.white,
    ),
    completed: StatusColorSet(
      main: PRFColors.success,
      background: PRFColors.successLight,
      onColor: PRFColors.white,
    ),
    failed: StatusColorSet(
      main: PRFColors.error,
      background: PRFColors.errorLight,
      onColor: PRFColors.white,
    ),
    ignored: StatusColorSet(
      main: PRFColors.gray500,
      background: PRFColors.gray100,
      onColor: PRFColors.white,
    ),
    // Active indicator
    active: PRFColors.emerald,
    activeGlow: Color(0x4010B981), // emerald with 25% opacity
  );

  /// Dark theme instance
  static const dark = PRFStatusExtension(
    // Standard statuses - slightly adjusted for dark mode
    success: StatusColorSet(
      main: PRFColors.success,
      background: Color(0xFF1A3D2A),
      onColor: PRFColors.white,
    ),
    warning: StatusColorSet(
      main: PRFColors.warning,
      background: Color(0xFF3D3A1A),
      onColor: PRFColors.black,
    ),
    error: StatusColorSet(
      main: Color(0xFFDC3545),
      background: Color(0xFF3D1A1A),
      onColor: PRFColors.white,
    ),
    info: StatusColorSet(
      main: PRFColors.info,
      background: Color(0xFF1A3D3D),
      onColor: PRFColors.white,
    ),
    // Mission statuses
    pending: StatusColorSet(
      main: PRFColors.orange,
      background: Color(0xFF3D2A1A),
      onColor: PRFColors.white,
    ),
    initiated: StatusColorSet(
      main: PRFColors.blue,
      background: Color(0xFF1A2A3D),
      onColor: PRFColors.white,
    ),
    scheduled: StatusColorSet(
      main: PRFColors.orange,
      background: Color(0xFF3D2A1A),
      onColor: PRFColors.white,
    ),
    inProgress: StatusColorSet(
      main: PRFColors.emerald,
      background: Color(0xFF1A3D2A),
      onColor: PRFColors.white,
    ),
    completed: StatusColorSet(
      main: PRFColors.success,
      background: Color(0xFF1A3D2A),
      onColor: PRFColors.white,
    ),
    failed: StatusColorSet(
      main: Color(0xFFDC3545),
      background: Color(0xFF3D1A1A),
      onColor: PRFColors.white,
    ),
    ignored: StatusColorSet(
      main: PRFColors.gray400,
      background: PRFColors.gray800,
      onColor: PRFColors.white,
    ),
    // Active indicator
    active: PRFColors.emerald,
    activeGlow: Color(0x4010B981),
  );

  @override
  PRFStatusExtension copyWith({
    StatusColorSet? success,
    StatusColorSet? warning,
    StatusColorSet? error,
    StatusColorSet? info,
    StatusColorSet? pending,
    StatusColorSet? initiated,
    StatusColorSet? scheduled,
    StatusColorSet? inProgress,
    StatusColorSet? completed,
    StatusColorSet? failed,
    StatusColorSet? ignored,
    Color? active,
    Color? activeGlow,
  }) {
    return PRFStatusExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      pending: pending ?? this.pending,
      initiated: initiated ?? this.initiated,
      scheduled: scheduled ?? this.scheduled,
      inProgress: inProgress ?? this.inProgress,
      completed: completed ?? this.completed,
      failed: failed ?? this.failed,
      ignored: ignored ?? this.ignored,
      active: active ?? this.active,
      activeGlow: activeGlow ?? this.activeGlow,
    );
  }

  @override
  PRFStatusExtension lerp(PRFStatusExtension? other, double t) {
    if (other is! PRFStatusExtension) return this;
    return PRFStatusExtension(
      success: StatusColorSet.lerp(success, other.success, t),
      warning: StatusColorSet.lerp(warning, other.warning, t),
      error: StatusColorSet.lerp(error, other.error, t),
      info: StatusColorSet.lerp(info, other.info, t),
      pending: StatusColorSet.lerp(pending, other.pending, t),
      initiated: StatusColorSet.lerp(initiated, other.initiated, t),
      scheduled: StatusColorSet.lerp(scheduled, other.scheduled, t),
      inProgress: StatusColorSet.lerp(inProgress, other.inProgress, t),
      completed: StatusColorSet.lerp(completed, other.completed, t),
      failed: StatusColorSet.lerp(failed, other.failed, t),
      ignored: StatusColorSet.lerp(ignored, other.ignored, t),
      active: Color.lerp(active, other.active, t)!,
      activeGlow: Color.lerp(activeGlow, other.activeGlow, t)!,
    );
  }
}
