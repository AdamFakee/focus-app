import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class IconThemes {
  static final _size = Sizes.iconMd;

  static IconThemeData get lightMode => IconThemeData(
    size: _size,
    color: AppColors.primary
  );

  static IconThemeData get darkMode => IconThemeData(
    size: _size,
    color: AppColors.primary
  );
}