import 'package:flutter/animation.dart';

/// Motion tokens keep interaction timing and easing consistent across widgets.
abstract final class PRFMotionTokens {
  static const Duration instant = Duration(milliseconds: 90);
  static const Duration fast = Duration(milliseconds: 140);
  static const Duration standard = Duration(milliseconds: 220);
  static const Duration slow = Duration(milliseconds: 320);

  static const Curve emphasized = Curves.easeOutCubic;
  static const Curve standardCurve = Curves.easeInOutCubic;
}
