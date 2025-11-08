import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/themes/customs/text/text_styles.dart';

class AppTextThemes {
  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.dark.white),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.dark.white),
      titleMedium: AppTextStyles.bodySm.copyWith(color: AppColors.dark.white),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: AppColors.dark.white),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.dark.white),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.dark.white),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.dark.white),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.dark.white),
    );
  }

  static TextTheme get lightTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.light.black),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.light.black),
      titleMedium: AppTextStyles.bodySm.copyWith(color: AppColors.light.black),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: AppColors.light.black),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.light.black),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.light.black),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.light.black),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.light.black),
    );
  }
}
