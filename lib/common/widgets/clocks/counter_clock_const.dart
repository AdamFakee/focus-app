import 'dart:math';
import 'package:flutter/material.dart';

class ClockConst {
  /// độ rộng vành cung
  static const double ringThickness = 45.0;

  /// ----- clock tick ---------
  static const double tickHeight = 12.0;
  static const double tickWidth = 2.5;
  static const int numOfTick = 17;

  static const Color ringColor = Color(0xFFE9E9E9);
  static const Color tickColor = Color(0xFFDCDCDC);
  static const Color progressColor = Colors.blue;

  // Góc bắt đầu và cung bị cắt
  static const double startAngle = 3 * pi / 4;
  static const double endAngle = pi - startAngle;

  // góc quét
  static double get sweepAngle => 2 * pi - (endAngle - startAngle).abs();

  /// Bán kính trung bình (vẽ giữa vành ngoài và trong)
  static double midRadius(double w) => (w / 2 + (w - ringThickness) / 2) / 2;
}
