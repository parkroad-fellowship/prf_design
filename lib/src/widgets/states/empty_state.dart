import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/states/empty_state/_handset.dart';
import 'package:prf_design/src/widgets/states/empty_state/_tablet.dart';

/// Empty-state screen with a centred icon, message and optional action.
///
/// Renders a full-screen scaffold: an optional app-bar-like [navBarTitle] with
/// back button, then an icon and message, then an optional CTA. Use [action] to
/// supply a custom widget, or [actionLabel] + [onActionPressed] for a primary
/// button.
///
/// Example:
/// ```dart
/// PRFEmptyView(
///   label: 'No missions yet',
///   description: 'Tap below to start your first mission.',
///   icon: Icons.rocket_launch_outlined,
///   actionLabel: 'Create mission',
///   onActionPressed: _createMission,
///   navBarTitle: 'Missions',
/// )
/// ```
class PRFEmptyView extends StatelessWidget {
  const PRFEmptyView({
    required this.label,
    required this.description,
    this.icon,
    this.action,
    this.actionLabel,
    this.onActionPressed,
    this.navBarTitle,
    this.onBackPressed,
    this.showBackButton = true,
    this.navBarActions,
    this.navBarBackgroundColor,
    this.navBarForegroundColor,
    super.key,
  });

  /// Headline message.
  final String label;

  /// Supporting explanation shown under the headline.
  final String description;

  /// Optional icon shown above the message.
  final IconData? icon;

  /// Custom action widget rendered below the message. Overrides
  /// [actionLabel]/[onActionPressed].
  final Widget? action;

  /// Label of the default primary action button.
  final String? actionLabel;

  /// Invoked when the default action button is pressed.
  final VoidCallback? onActionPressed;

  /// Optional top-bar title shown with a back button.
  final String? navBarTitle;

  /// Invoked when the top-bar back button is pressed; defaults to `pop`.
  final VoidCallback? onBackPressed;

  /// When false the back button is hidden. Defaults to true.
  final bool showBackButton;

  /// Optional trailing actions for the top bar.
  final List<Widget>? navBarActions;

  /// Overrides the top-bar background colour.
  final Color? navBarBackgroundColor;

  /// Overrides the top-bar foreground colour.
  final Color? navBarForegroundColor;

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFEmptyViewHandset(
        label: label,
        description: description,
        icon: icon,
        action: action,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        navBarTitle: navBarTitle,
        onBackPressed: onBackPressed,
        showBackButton: showBackButton,
        navBarActions: navBarActions,
        navBarBackgroundColor: navBarBackgroundColor,
        navBarForegroundColor: navBarForegroundColor,
      ),
      tablet: (_) => PRFEmptyViewTablet(
        label: label,
        description: description,
        icon: icon,
        action: action,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        navBarTitle: navBarTitle,
        onBackPressed: onBackPressed,
        showBackButton: showBackButton,
        navBarActions: navBarActions,
        navBarBackgroundColor: navBarBackgroundColor,
        navBarForegroundColor: navBarForegroundColor,
      ),
      builder: (_, _) => PRFEmptyViewTablet(
        label: label,
        description: description,
        icon: icon,
        action: action,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        navBarTitle: navBarTitle,
        onBackPressed: onBackPressed,
        showBackButton: showBackButton,
        navBarActions: navBarActions,
        navBarBackgroundColor: navBarBackgroundColor,
        navBarForegroundColor: navBarForegroundColor,
      ),
    );
  }
}
