import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/cards/detail_action_card/_handset.dart';
import 'package:prf_design/src/widgets/cards/detail_action_card/_tablet.dart';

class PRFDetailActionCard extends StatelessWidget {
  const PRFDetailActionCard({
    required this.title,
    required this.subtitle,
    super.key,
    this.onTap,
    this.leading,
    this.trailing,
    this.footer,
    this.margin,
    this.padding,
    this.backgroundColor,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final Widget? footer;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFDetailActionCardTablet(
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        leading: leading,
        trailing: trailing,
        footer: footer,
        margin: margin,
        padding: padding,
        backgroundColor: backgroundColor,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFDetailActionCardHandset(
          title: title,
          subtitle: subtitle,
          onTap: onTap,
          leading: leading,
          trailing: trailing,
          footer: footer,
          margin: margin,
          padding: padding,
          backgroundColor: backgroundColor,
        ),
        tablet: (_, _) => PRFDetailActionCardTablet(
          title: title,
          subtitle: subtitle,
          onTap: onTap,
          leading: leading,
          trailing: trailing,
          footer: footer,
          margin: margin,
          padding: padding,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
