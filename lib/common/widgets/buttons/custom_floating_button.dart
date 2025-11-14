import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color? bg;
  final Color? iconColor;

  const CustomFloatingButton({
    super.key,
    this.icon = Icons.add,
    required this.onPressed,
    this.bg,
    this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(Sizes.all)
      ),
      backgroundColor: bg ?? AppColors.primary,
      onPressed: onPressed,
      child: Icon(
        icon,
        color: iconColor ?? Colors.white,
      ),
    );
  }
}