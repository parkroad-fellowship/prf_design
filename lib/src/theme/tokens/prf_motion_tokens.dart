import 'package:flutter/animation.dart';

/// Motion tokens keep interaction timing and easing consistent across widgets.
abstract final class PRFMotionTokens {
  static const Duration instant = Duration(milliseconds: 90);
  static const Duration fast = Duration(milliseconds: 140);
  static const Duration standard = Duration(milliseconds: 220);
  static const Duration slow = Duration(milliseconds: 320);
  static const Duration enterShort = Duration(milliseconds: 600);
  static const Duration enterMedium = Duration(milliseconds: 800);

  static const Duration stagger1 = Duration(milliseconds: 100);
  static const Duration stagger2 = Duration(milliseconds: 200);
  static const Duration stagger3 = Duration(milliseconds: 300);
  static const Duration stagger4 = Duration(milliseconds: 400);
  static const Duration stagger5 = Duration(milliseconds: 500);

  static const double pressedScale = 0.97;

  static const Curve emphasized = Curves.easeOutCubic;
  static const Curve standardCurve = Curves.easeInOutCubic;
}
