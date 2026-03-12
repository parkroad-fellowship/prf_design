import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/navigation/_handset.dart';
import 'package:prf_design/src/widgets/navigation/_tablet.dart';

class PRFNavBar extends StatelessWidget {
  const PRFNavBar({
    required this.title,
    super.key,
    this.onBack,
    this.actions,
    this.backIcon,
    this.backgroundColor,
    this.centerTitle = true,
    this.isSliver = true,
  });

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final IconData? backIcon;
  final Color? backgroundColor;
  final bool centerTitle;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    final navBar = AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFNavBarTablet(
        title: title,
        onBack: onBack,
        actions: actions,
        backIcon: backIcon,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        isSliver: isSliver,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFNavBarHandset(
          title: title,
          onBack: onBack,
          actions: actions,
          backIcon: backIcon,
          backgroundColor: backgroundColor,
          centerTitle: centerTitle,
          isSliver: isSliver,
        ),
        tablet: (_, _) => PRFNavBarTablet(
          title: title,
          onBack: onBack,
          actions: actions,
          backIcon: backIcon,
          backgroundColor: backgroundColor,
          centerTitle: centerTitle,
          isSliver: isSliver,
        ),
      ),
    );

    if (!isSliver) {
      return SafeArea(child: navBar);
    }

    return navBar;
  }
}

class PRFAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PRFAppBar({
    required this.title,
    super.key,
    this.onBack,
    this.actions,
    this.backIcon,
    this.backgroundColor,
    this.centerTitle = true,
  });

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final IconData? backIcon;
  final Color? backgroundColor;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return PRFNavBar(
      title: title,
      onBack: onBack,
      actions: actions,
      backIcon: backIcon,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      isSliver: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
