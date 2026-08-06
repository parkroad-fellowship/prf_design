import 'package:flutter/widgets.dart';

/// Motion tokens keep interaction timing and easing consistent across widgets.
abstract final class PRFMotionTokens {
  static const Duration instant = Duration(milliseconds: 80);
  static const Duration fast = Duration(milliseconds: 160);
  static const Duration standard = Duration(milliseconds: 240);
  static const Duration slow = Duration(milliseconds: 360);
  static const Duration enterShort = Duration(milliseconds: 420);
  static const Duration enterMedium = Duration(milliseconds: 560);

  static const Duration stagger1 = Duration(milliseconds: 50);
  static const Duration stagger2 = Duration(milliseconds: 100);
  static const Duration stagger3 = Duration(milliseconds: 150);
  static const Duration stagger4 = Duration(milliseconds: 200);
  static const Duration stagger5 = Duration(milliseconds: 250);

  static const double pressedScale = 0.985;

  static const Curve emphasized = Curves.easeOutQuart;
  static const Curve standardCurve = Curves.easeInOut;

  // Returns Duration.zero when the user has requested reduced motion.
  static Duration resolve(BuildContext context, Duration duration) =>
      MediaQuery.of(context).disableAnimations ? Duration.zero : duration;
}
