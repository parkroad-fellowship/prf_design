import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/cards/action_card/_handset.dart';
import 'package:prf_design/src/widgets/cards/action_card/_tablet.dart';

class PRFActionCard extends StatelessWidget {
  const PRFActionCard({
    required this.title,
    required this.image,
    super.key,
    this.onTap,
  });

  final String title;
  final Widget image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFActionCardTablet(
        title: title,
        image: image,
        onTap: onTap,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFActionCardHandset(
          title: title,
          image: image,
          onTap: onTap,
        ),
        tablet: (_, _) => PRFActionCardTablet(
          title: title,
          image: image,
          onTap: onTap,
        ),
      ),
    );
  }
}
