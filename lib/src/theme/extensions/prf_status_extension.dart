import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/_index.dart';
import 'package:prf_design/src/theme/colors/prf_color_utils.dart';
import 'package:prf_design/src/theme/tokens/prf_status_tokens.dart';

/// Represents a complete status color set with main, background & text colors.
///
/// Every PRF-provided set guarantees two WCAG AA (≥ 4.5:1) pairs:
/// - [onColor] on [main] — for filled badges, snackbars and chips;
/// - [foreground] on [background] — for tinted containers and status text.
///
/// [main] is a fill / indicator colour. Do not use it as text on [background]
/// (bright hues such as warning amber cannot reach 4.5:1 on their own tint);
/// use [foreground] instead.
@immutable
class StatusColorSet {
  const StatusColorSet({
    required this.main,
    required this.background,
    required this.onColor,
    this._foreground,
  });

  factory StatusColorSet.lerp(StatusColorSet a, StatusColorSet b, double t) {
    return StatusColorSet(
      main: Color.lerp(a.main, b.main, t)!,
      background: Color.lerp(a.background, b.background, t)!,
      onColor: Color.lerp(a.onColor, b.onColor, t)!,
      foreground: Color.lerp(a.foreground, b.foreground, t),
    );
  }

  /// The main/primary color for the status (fill or indicator).
  final Color main;

  /// Light background color for containers/cards
  final Color background;

  /// Text/icon color to use on the main color
  final Color onColor;

  final Color? _foreground;

  /// Text/icon color to use on [background]. Falls back to [main] when the set
  /// was constructed without an explicit foreground.
  Color get foreground => _foreground ?? main;

  StatusColorSet copyWith({
    Color? main,
    Color? background,
    Color? onColor,
    Color? foreground,
  }) {
    return StatusColorSet(
      main: main ?? this.main,
      background: background ?? this.background,
      onColor: onColor ?? this.onColor,
      foreground: foreground ?? _foreground,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusColorSet &&
          runtimeType == other.runtimeType &&
          main == other.main &&
          background == other.background &&
          onColor == other.onColor &&
          foreground == other.foreground;

  @override
  int get hashCode => Object.hash(main, background, onColor, foreground);
}

/// ThemeExtension providing semantic status colors.
///
/// Access via BuildContext:
/// ```dart
/// final status = Theme.of(context).extension<PRFStatusExtension>()!;
/// // or with convenience extension:
/// final status = context.statusColors;
/// ```
///
/// Pairs: `onColor` on `main` for fills, `foreground` on `background` for
/// tints. Both are ≥ 4.5:1 in light and dark.
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

  /// Every status set, in declaration order.
  List<StatusColorSet> get all => [
    success,
    warning,
    error,
    info,
    pending,
    initiated,
    scheduled,
    inProgress,
    completed,
    failed,
    ignored,
  ];

  /// Readable text/icon colour for an arbitrary status [fill].
  ///
  /// Returns the matching set's [StatusColorSet.onColor] when [fill] is one of
  /// this extension's `main` colours; otherwise picks white or deep navy,
  /// whichever contrasts more with [fill].
  Color onColorFor(Color fill) {
    for (final set in all) {
      if (set.main == fill) return set.onColor;
    }
    return PRFColorUtils.mostReadable(fill, const [
      PRFColors.white,
      PRFColors.navy900,
    ]);
  }

  /// Light theme instance
  static const light = PRFStatusExtension(
    // Standard statuses
    success: StatusColorSet(
      main: PRFColors.successDark,
      background: PRFColors.successLight,
      onColor: PRFColors.white,
      foreground: PRFColors.successDark,
    ),
    warning: StatusColorSet(
      main: PRFColors.warning,
      background: PRFColors.warningLight,
      onColor: PRFColors.black,
      foreground: PRFColors.warningText,
    ),
    error: StatusColorSet(
      main: PRFColors.error,
      background: PRFColors.errorLight,
      onColor: PRFColors.white,
      foreground: PRFColors.errorDark,
    ),
    info: StatusColorSet(
      main: PRFColors.infoDark,
      background: PRFColors.infoLight,
      onColor: PRFColors.white,
      foreground: PRFColors.infoDark,
    ),
    // Mission statuses
    pending: StatusColorSet(
      main: PRFColors.orange,
      background: PRFStatusTokens.pendingBackgroundLight,
      onColor: PRFColors.navy900,
      foreground: PRFColors.orangeText,
    ),
    initiated: StatusColorSet(
      main: PRFColors.blueDark,
      background: PRFStatusTokens.initiatedBackgroundLight,
      onColor: PRFColors.white,
      foreground: PRFColors.blueDark,
    ),
    scheduled: StatusColorSet(
      main: PRFColors.orange,
      background: PRFStatusTokens.pendingBackgroundLight,
      onColor: PRFColors.navy900,
      foreground: PRFColors.orangeText,
    ),
    inProgress: StatusColorSet(
      main: PRFColors.emerald,
      background: PRFStatusTokens.inProgressBackgroundLight,
      onColor: PRFColors.navy900,
      foreground: PRFColors.emeraldText,
    ),
    completed: StatusColorSet(
      main: PRFColors.successDark,
      background: PRFColors.successLight,
      onColor: PRFColors.white,
      foreground: PRFColors.successDark,
    ),
    failed: StatusColorSet(
      main: PRFColors.error,
      background: PRFColors.errorLight,
      onColor: PRFColors.white,
      foreground: PRFColors.errorDark,
    ),
    ignored: StatusColorSet(
      main: PRFColors.gray600,
      background: PRFColors.gray100,
      onColor: PRFColors.white,
      foreground: PRFColors.gray700,
    ),
    // Active indicator
    active: PRFColors.emerald,
    activeGlow: PRFStatusTokens.activeGlow,
  );

  /// Dark theme instance. Fills are bright tones carrying deep-navy text, the
  /// Material 3 dark convention, so they stay legible on dark surfaces.
  static const dark = PRFStatusExtension(
    // Standard statuses
    success: StatusColorSet(
      main: PRFColors.successBright,
      background: PRFStatusTokens.successBackgroundDark,
      onColor: PRFColors.navy900,
      foreground: PRFColors.successBright,
    ),
    warning: StatusColorSet(
      main: PRFColors.warning,
      background: PRFStatusTokens.warningBackgroundDark,
      onColor: PRFColors.black,
      foreground: PRFColors.warning,
    ),
    error: StatusColorSet(
      main: PRFColors.errorBright,
      background: PRFStatusTokens.errorBackgroundDark,
      onColor: PRFColors.navy900,
      foreground: PRFColors.errorBright,
    ),
    info: StatusColorSet(
      main: PRFColors.infoBright,
      background: PRFStatusTokens.infoBackgroundDark,
      onColor: PRFColors.navy900,
      foreground: PRFColors.infoBright,
    ),
    // Mission statuses
    pending: StatusColorSet(
      main: PRFColors.orange,
      background: PRFStatusTokens.pendingBackgroundDark,
      onColor: PRFColors.navy900,
      foreground: PRFColors.orange,
    ),
    initiated: StatusColorSet(
      main: PRFColors.blueBright,
      background: PRFStatusTokens.initiatedBackgroundDark,
      onColor: PRFColors.navy900,
      foreground: PRFColors.blueBright,
    ),
    scheduled: StatusColorSet(
      main: PRFColors.orange,
      background: PRFStatusTokens.pendingBackgroundDark,
      onColor: PRFColors.navy900,
      foreground: PRFColors.orange,
    ),
    inProgress: StatusColorSet(
      main: PRFColors.emerald,
      background: PRFStatusTokens.inProgressBackgroundDark,
      onColor: PRFColors.navy900,
      foreground: PRFColors.emerald,
    ),
    completed: StatusColorSet(
      main: PRFColors.successBright,
      background: PRFStatusTokens.successBackgroundDark,
      onColor: PRFColors.navy900,
      foreground: PRFColors.successBright,
    ),
    failed: StatusColorSet(
      main: PRFColors.errorBright,
      background: PRFStatusTokens.errorBackgroundDark,
      onColor: PRFColors.navy900,
      foreground: PRFColors.errorBright,
    ),
    ignored: StatusColorSet(
      main: PRFColors.gray400,
      background: PRFColors.gray800,
      onColor: PRFColors.navy900,
      foreground: PRFColors.gray400,
    ),
    // Active indicator
    active: PRFColors.emerald,
    activeGlow: PRFStatusTokens.activeGlow,
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
