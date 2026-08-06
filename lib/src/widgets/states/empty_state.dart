import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/states/empty_state/_handset.dart';
import 'package:prf_design/src/widgets/states/empty_state/_tablet.dart';

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

  final String label;
  final String description;
  final IconData? icon;
  final Widget? action;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final String? navBarTitle;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final List<Widget>? navBarActions;
  final Color? navBarBackgroundColor;
  final Color? navBarForegroundColor;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFEmptyViewTablet(
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
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFEmptyViewHandset(
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
        tablet: (_, _) => PRFEmptyViewTablet(
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
      ),
    );
  }
}
