import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/cards/stat_highlight_card/_handset.dart';
import 'package:prf_design/src/widgets/cards/stat_highlight_card/_tablet.dart';

class StatHighlightCard extends StatelessWidget {
  const StatHighlightCard({
    required this.title,
    required this.subtitle,
    this.icon,
    this.gradient,
    this.delay = Duration.zero,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData? icon;
  final List<Color>? gradient;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => StatHighlightCardTablet(
        title: title,
        subtitle: subtitle,
        icon: icon,
        gradient: gradient,
        delay: delay,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => StatHighlightCardHandset(
          title: title,
          subtitle: subtitle,
          icon: icon,
          gradient: gradient,
          delay: delay,
        ),
        tablet: (_, _) => StatHighlightCardTablet(
          title: title,
          subtitle: subtitle,
          icon: icon,
          gradient: gradient,
          delay: delay,
        ),
      ),
    );
  }
}
