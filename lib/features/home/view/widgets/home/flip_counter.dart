import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/global.dart';

/// Dùng để hiển thị đồng hồ dạng lật thẻ (FlipClock)
/// 
/// Hướng làm animation tham khảo từ source: `https://github.com/imtheguna/flutter_flip_card`
/// 
/// Nếu phần comment giải thích mục đính từng card khó hiểu => có thể bgColor để dễ hình dung hơn. `Ví dụ`:
/// 
/// ```dart
/// cardHaflDigit(
///  currentValue: valueToFlipFrom,
///  bg: Colors.red
/// )
/// ```
class FlipCounter extends StatefulWidget {
  final int currentValue;
  
  const FlipCounter({
    super.key, 
    required this.currentValue, 
  });

  @override
  State<FlipCounter> createState() => _FlipCounterState();
}

class _FlipCounterState extends State<FlipCounter> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  int? oldCurrentValue;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void didUpdateWidget(covariant FlipCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    //- current value khác nhau => có giá trị mới => chạy animation
    if (widget.currentValue != oldWidget.currentValue) {
      oldCurrentValue = oldWidget.currentValue;
      controller..reset()..forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return card();
  }

  Widget card() {
    // giá trị cũ để hiển thị
    final valueToFlipFrom = oldCurrentValue ?? widget.currentValue;

    return SizedBox(
      height: Globals.flipCounterTimerCardHeight + Globals.halfFlipCounterTimerCardSpacing,
      child: Stack(
        children: [
          //- thẻ chứa giá trị cũ nằm dưới
          Align(
            alignment: Alignment.bottomCenter,
            child: cardHaflDigit(
              currentValue: valueToFlipFrom, 
              isTop: false,
            ),
          ),

          //- Các thẻ nằm trên chứa giá trị mới & cũ
          Stack(
            children: [
              cardHaflDigit(
                currentValue: widget.currentValue, 
              ),
                
              AnimatedBuilder(
                animation: animation, 
                builder:(context, child) {
                  // lật 180 độ
                  final angle = pi * animation.value;

                  // di chuyển lên để bù phần spacing [Globals.halfFlipCounterTimerCardSpacing]
                  final oy = -Globals.halfFlipCounterTimerCardSpacing * animation.value;

                  final transform = Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(angle)

                              // dùng translate vì dùng với matrix thì animation bị mất ( Không hiểu sao mất )
                              ..translate(0.0,  oy);
                              
                  // Thẻ lật từ top xuống bottom => bị ngược 
                  // cần lật lại cho đúng hướng
                  final transformForBack = Matrix4.identity()..rotateX(pi);
                                
                  return Transform(
                    alignment: Alignment.bottomCenter,
                    transform: transform,

                    // khi thẻ lật từ trên xuống đủ 90 độ => đổi thẻ chứa giá trị cũ -> thẻ chứa giá trị mới và lật thẻ này cho đúng hướng
                    child: isFrontWidget(angle.abs())
                      ? cardHaflDigit(
                        currentValue: valueToFlipFrom,
                      )
                      : Transform(
                        transform: transformForBack,
                        alignment: Alignment.center,
                        child: cardHaflDigit(
                          currentValue: widget.currentValue,
                          isTop: false,
                        ),
                      )
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// kiểm trả xem hình ở trên khi gập xuống có nằm ở phần từ tâm đổ lên không 
  /// 
  /// Nghĩa là kiểm tra phạm vi để hiển thị [FontWiget] hay à [BackWidget]
  bool isFrontWidget(double angle) {
    const degrees90 = pi / 2;
    const degrees270 = 3 * pi / 2;
    return angle <= degrees90 || angle >= degrees270;
  }

  /// cắt đôi ký tự truyền vào
  /// 
  /// `isTop`: thẻ trên hay thẻ dưới
  Widget cardHaflDigit({
    bool isTop = true,
    int currentValue = 2,
    Color? bg,
  }) {
    return ClipRect(
      child: Align(
        /// chọn điểm bắt đầu, đại khái thế
        alignment: isTop ? Alignment.topCenter : Alignment.bottomCenter,
        heightFactor: 0.5,
        child: Container(
          width: 150,
          height: 175,
          decoration: BoxDecoration(
            color: bg ?? Color(0xFF252A34),
            borderRadius: BorderRadius.only(
              topLeft: isTop ? Radius.circular(12) : Radius.zero,
              topRight: isTop ? Radius.circular(12) : Radius.zero,
              bottomLeft: isTop ? Radius.zero : Radius.circular(12),
              bottomRight: isTop ? Radius.zero : Radius.circular(12),
            ),
          ),
          child: Center(
            child: FlipCouterText(
              value: currentValue.toString(),
            ),
          ),
        ),
      ),
    );
  }
}

class FlipCouterText extends StatelessWidget {
  final String value;
  const FlipCouterText({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        color: AppColors.white,
        fontSize: 180,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
