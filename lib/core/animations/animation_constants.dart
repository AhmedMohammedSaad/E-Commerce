import 'package:flutter/material.dart';

class AnimationConstants {
  // Durations
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // Curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bouncyCurve = Curves.elasticOut;
  static const Curve sharpCurve = Curves.easeOutCubic;

  // Scale factors
  static const double buttonPressedScale = 0.95;
  static const double buttonHoverScale = 1.05;
}
