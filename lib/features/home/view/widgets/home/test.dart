import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';

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

  int? oldValue;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void didUpdateWidget(covariant FlipCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentValue != oldWidget.currentValue) {
      oldValue = oldWidget.currentValue;
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
  final valueToFlipFrom = oldValue ?? widget.currentValue;

  return SizedBox(
    height: 178,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: cardHaflDigit(
            currentValue: valueToFlipFrom, 
            isTop: false,
            bg: Colors.green
          ),
        ),
        Stack(
          children: [
            cardHaflDigit(
              currentValue: widget.currentValue, 
              bg: Colors.amber
            ),
              
            AnimatedBuilder(
              animation: animation, 
              builder:(context, child) {
                final angle = pi * animation.value;
                final transform = Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateX(angle)
                            ..translate(0.0,  -3.0 * animation.value);
                             
                final transformForBack = Matrix4.identity()..rotateX(pi);
                              
                return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: transform,
                  child: isFrontWidget(angle.abs())
                    ? cardHaflDigit(
                      bg: Colors.red,
                      currentValue: valueToFlipFrom, 
                    )
                    : Transform(
                      transform: transformForBack,
                      alignment: Alignment.center,
                      child: cardHaflDigit(
                          currentValue: widget.currentValue,
                          isTop: false,
                          bg: Colors.blue
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

  bool isFrontWidget(double angle) {
    const degrees90 = pi / 2;
    const degrees270 = 3 * pi / 2;
    return angle <= degrees90 || angle >= degrees270;
  }
  Widget cardHaflDigit({
      bool isTop = true,
      int currentValue = 2,
      Color? bg
  }) {
    return ClipRect(
      child: Align(
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
            )
          ),
          child: Center(
            child: FlipCouterText(value: currentValue.toString(),)
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
