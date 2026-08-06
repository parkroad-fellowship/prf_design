import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/cards/animated_stat_card/_handset.dart';
import 'package:prf_design/src/widgets/cards/animated_stat_card/_tablet.dart';

class AnimatedStatCard extends StatelessWidget {
  const AnimatedStatCard({
    required this.value,
    required this.label,
    this.icon,
    this.color,
    this.delay = Duration.zero,
    super.key,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color? color;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => AnimatedStatCardTablet(
        value: value,
        label: label,
        icon: icon,
        color: color,
        delay: delay,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => AnimatedStatCardHandset(
          value: value,
          label: label,
          icon: icon,
          color: color,
          delay: delay,
        ),
        tablet: (_, _) => AnimatedStatCardTablet(
          value: value,
          label: label,
          icon: icon,
          color: color,
          delay: delay,
        ),
      ),
    );
  }
}
