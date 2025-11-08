import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/themes/customs/text/text_theme.dart';

class InputDecorationThemes {
  InputDecorationThemes._();

  static final _radius = Sizes.borderRadiusSm;
  static final double _borderWidth = 1;

  static InputDecorationTheme darkTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.primary,
    suffixIconColor: AppColors.primary,
    labelStyle: AppTextThemes.darkTextTheme.bodyMedium,
    hintStyle: AppTextThemes.darkTextTheme.bodyMedium,
    errorStyle: AppTextThemes.darkTextTheme.bodyMedium!.copyWith(color: AppColors.red),
    floatingLabelStyle: TextStyle(color: Colors.black), ///
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.dark.whiteDark),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.dark.whiteDark),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.dark.whiteDark),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.primary),
    ),
  );

  static InputDecorationTheme lightTheme = InputDecorationTheme(
    errorMaxLines: 3,
    filled: true,
    fillColor: AppColors.light.backgroundGray,
    prefixIconColor: AppColors.light.black,
    suffixIconColor: AppColors.light.black,
    labelStyle: AppTextThemes.lightTextTheme.bodyMedium,
    hintStyle: AppTextThemes.lightTextTheme.bodyMedium,
    errorStyle: AppTextThemes.lightTextTheme.bodyMedium!.copyWith(color: AppColors.red),
    floatingLabelStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.light.backgroundGray),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.light.backgroundGray),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.light.black),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(width: _borderWidth, color: AppColors.primary),
    ),
  );
}
