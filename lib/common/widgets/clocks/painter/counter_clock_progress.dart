import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/clocks/counter_clock_const.dart';

/// `progress`: hiển thị bao nhiêu phần trăm [0, 1.0]
class CounterClockProgress extends CustomPainter {
  final double progress; // từ 0.0 đến 1.0

  CounterClockProgress({required this.progress}) :  assert(
    progress >= 0.0 && progress <= 1.0,
    'Progress must be between 0.0 and 1.0'
  );

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);


    // bán kính trung bình
    final midRadius = (w / 2 + (w - ClockConst.ringThickness) / 2) / 2;

    final paintProgress = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = ClockConst.ringThickness / 2 
      ..strokeCap = StrokeCap.round;

    // Vẽ cung progress
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: midRadius),
      ClockConst.startAngle,
      ClockConst.sweepAngle * progress,
      false,
      paintProgress,
    );
  }

  @override
  bool shouldRepaint(covariant CounterClockProgress oldDelegate) =>
      oldDelegate.progress != progress;
}
