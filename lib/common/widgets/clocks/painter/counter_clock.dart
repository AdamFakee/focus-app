import 'dart:math';
import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/clocks/counter_clock_const.dart';

/// widget này không cần re-paint
class CounterClock extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = min(size.height, size.width);
    final h = min(size.height, size.width);
    final center = Offset(w / 2, h / 2);
    final radius = ClockConst.ringThickness / 4;

    // Paint cho vành cung
    final paintRing = Paint()
      ..color = Color(0xFFE9E9E9)
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 0.2);


    // Hình ngoài và trong (đồng tâm)
    final outerRect = Rect.fromCenter(center: center, width: w, height: h);
    final innerRect = Rect.fromCenter(
      center: center,
      width: w - ClockConst.ringThickness,
      height: h - ClockConst.ringThickness,
    );

    // === Vẽ 2 đầu tròn ===
    // bán kính của hình tròn nằm giữa inner và outer
    final double midRadius = (w / 2 + (w - ClockConst.ringThickness) / 2) / 2;


    final startPoint = Offset(
      center.dx + midRadius * cos(ClockConst.startAngle),
      center.dy + midRadius * sin(ClockConst.startAngle),
    );
    final endPoint = Offset(
      center.dx + midRadius * cos(ClockConst.startAngle + ClockConst.sweepAngle),
      center.dy + midRadius * sin(ClockConst.startAngle + ClockConst.sweepAngle),
    );

    final path = Path();

    // Bắt đầu từ đầu cung
    path.moveTo(
      center.dx + (midRadius - radius) * cos(ClockConst.startAngle),
      center.dy + (midRadius - radius) * sin(ClockConst.startAngle),
    );

    // Vành cung ngoài
    path.arcTo(
      outerRect,
      ClockConst.startAngle,
      ClockConst.sweepAngle,
      true
    );

    // Nửa vòng tròn cuối
    path.arcTo(
      Rect.fromCircle(center: endPoint, radius: radius),
      ClockConst.startAngle + ClockConst.sweepAngle,
      pi,
      false,
    );

    // Vành cung trong
    path.arcTo(innerRect, ClockConst.startAngle + ClockConst.sweepAngle, -ClockConst.sweepAngle, false);
    

    // Nửa vòng tròn đầu
    path.arcTo(
      Rect.fromCircle(center: startPoint, radius: radius),
      ClockConst.startAngle + pi,
      pi,
      false,
    );

    canvas.drawPath(path, paintRing);



    // --------------- Vẽ đường kẻ kim đồng hồ -------------
    final angleSpacing = ClockConst.sweepAngle / (ClockConst.numOfTick - 1);
    final lineRadius = w / 2 - ClockConst.ringThickness * 0.9;

    final linePath = Path();

    for (int i = 0; i < ClockConst.numOfTick; i++) {
      final angle = ClockConst.startAngle + i * angleSpacing;

      final startPoint = Offset(
        center.dx + lineRadius * cos(angle),
        center.dy + lineRadius * sin(angle),
      );

      final endPoint = Offset(
        center.dx + (lineRadius - ClockConst.tickHeight) * cos(angle),
        center.dy + (lineRadius - ClockConst.tickHeight) * sin(angle),
      );

      linePath.moveTo(startPoint.dx, startPoint.dy);
      linePath.lineTo(endPoint.dx, endPoint.dy);
    }

    // Vẽ tất cả đường kẻ
    canvas.drawPath(
      linePath,
      Paint()
        ..color = Color(0xFFDCDCDC)
        ..strokeWidth = ClockConst.tickWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}




// ----- code gốc ---


// import 'dart:math';
// import 'package:flutter/material.dart';

// class CounterClock extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final w = size.width;
//     final h = size.height;
//     final center = Offset(w / 2, h / 2);
//     final ringThickness = 45.0;
//     final radius = ringThickness / 4;

//     // Góc bắt đầu
//     double startAngle = 3 * pi / 4;
//     // Góc đối xứng qua Oy
//     double endAngle = pi - startAngle;
//     // Góc nhỏ giữa 2 điểm
//     double smallSweep = (endAngle - startAngle).abs();
//     // Cung lớn (phần diện tích quét lớn nhất)
//     double sweepAngle = 2 * pi - smallSweep;

//     // Paint cho vành cung
//     final paintRing = Paint()
//       ..color = Color(0xFFE9E9E9)
//       ..style = PaintingStyle.fill
//       ..maskFilter = MaskFilter.blur(BlurStyle.inner, 0.2);


//     // Hình ngoài và trong (đồng tâm)
//     final outerRect = Rect.fromCenter(center: center, width: w, height: h);
//     final innerRect = Rect.fromCenter(
//       center: center,
//       width: w - ringThickness,
//       height: h - ringThickness,
//     );

//     // === Vẽ 2 đầu tròn ===
//     // bán kính của hình tròn nằm giữa inner và outer
//     final double midRadius = (w / 2 + (w - ringThickness) / 2) / 2;


//     final startPoint = Offset(
//       center.dx + midRadius * cos(startAngle),
//       center.dy + midRadius * sin(startAngle),
//     );
//     final endPoint = Offset(
//       center.dx + midRadius * cos(startAngle + sweepAngle),
//       center.dy + midRadius * sin(startAngle + sweepAngle),
//     );

//     final path = Path();

//     // Bắt đầu từ đầu cung
//     path.moveTo(
//       center.dx + (midRadius - radius) * cos(startAngle),
//       center.dy + (midRadius - radius) * sin(startAngle),
//     );

//     // Vành cung ngoài
//     path.arcTo(
//       outerRect,
//       startAngle,
//       sweepAngle,
//       true
//     );

//     // Nửa vòng tròn cuối
//     path.arcTo(
//       Rect.fromCircle(center: endPoint, radius: radius),
//       startAngle + sweepAngle,
//       pi,
//       false,
//     );

//     // Vành cung trong
//     path.arcTo(innerRect, startAngle + sweepAngle, -sweepAngle, false);
    

//     // Nửa vòng tròn đầu
//     path.arcTo(
//       Rect.fromCircle(center: startPoint, radius: radius),
//       startAngle + pi,
//       pi,
//       false,
//     );

//     canvas.drawPath(path, paintRing);



//     // --------------- Vẽ đường kẻ kim đồng hồ -------------
//     final lineRadius = w / 2 - ringThickness * 0.9;
//     final lineWidth = 2.5;
//     final lineHeight = 12;
//     final numOfLine = 17;
//     final angleSpacing = sweepAngle / (numOfLine - 1);
//     final linePath = Path();

//     for (int i = 0; i < numOfLine; i++) {
//       final angle = startAngle + i * angleSpacing;

//       final startPoint = Offset(
//         center.dx + lineRadius * cos(angle),
//         center.dy + lineRadius * sin(angle),
//       );

//       final endPoint = Offset(
//         center.dx + (lineRadius - lineHeight) * cos(angle),
//         center.dy + (lineRadius - lineHeight) * sin(angle),
//       );

//       linePath.moveTo(startPoint.dx, startPoint.dy);
//       linePath.lineTo(endPoint.dx, endPoint.dy);
//     }

//     // Vẽ tất cả đường kẻ
//     canvas.drawPath(
//       linePath,
//       Paint()
//         ..color = Color(0xFFDCDCDC)
//         ..strokeWidth = lineWidth
//         ..strokeCap = StrokeCap.round
//         ..style = PaintingStyle.stroke,
//     );


//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }


// /// `progress`: hiển thị bao nhiêu phần trăm [0, 1.0]
// class CounterClockProgress extends CustomPainter {
//   final double progress; // từ 0.0 đến 1.0

//   CounterClockProgress({required this.progress}) :  assert(
//     progress >= 0.0 && progress <= 1.0,
//     'Progress must be between 0.0 and 1.0'
//   );

//   @override
//   void paint(Canvas canvas, Size size) {
//     final w = size.width;
//     final h = size.height;
//     final center = Offset(w / 2, h / 2);
//     final ringThickness = 45.0;

//     final startAngle = 3 * pi / 4;
//     final endAngle = pi - startAngle;
//     final smallSweep = (endAngle - startAngle).abs();
//     final fullSweep = 2 * pi - smallSweep;

//     final sweepAngle = fullSweep * progress;

//     // bán kính trung bình
//     final midRadius = (w / 2 + (w - ringThickness) / 2) / 2;

//     final paintProgress = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = ringThickness / 2 
//       ..strokeCap = StrokeCap.round;

//     // Vẽ cung progress
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: midRadius),
//       startAngle,
//       sweepAngle,
//       false,
//       paintProgress,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CounterClockProgress oldDelegate) =>
//       oldDelegate.progress != progress;
// }