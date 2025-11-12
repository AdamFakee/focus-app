import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class RoundedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final double px;
  final double py;
  final Color? bg;
  final Widget child;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final VoidCallback? onPressed;

  const RoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = Sizes.md,
    this.px = Sizes.md,
    this.py = Sizes.md,
    this.bg,
    this.border,
    this.shadow,
    required this.child,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: px, vertical: py),
        decoration: BoxDecoration(
          color: bg ?? AppColors.white,
          borderRadius: BorderRadius.circular(radius),
          border: border,
          boxShadow: shadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(1, 2),
                ),
              ],
        ),
        child: child,
      ),
    );
  }
}
