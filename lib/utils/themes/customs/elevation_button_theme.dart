import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/themes/customs/text/text_theme.dart';

class ElevationButtonThemes {
  static ElevatedButtonThemeData get darkTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 0),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.dark.black,
      disabledBackgroundColor: AppColors.primary.withOpacity(0.8),
      disabledForegroundColor: AppColors.dark.black,
      elevation: Sizes.buttonElevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadiusLg)),
      side: BorderSide(
        color: AppColors.primary,
      ),
      textStyle: AppTextThemes.darkTextTheme.bodyLarge,
      padding: EdgeInsets.symmetric(
        vertical: Sizes.md
      )
    )
  );

  static ElevatedButtonThemeData get lightTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 0),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.primary.withOpacity(0.8),
      disabledForegroundColor: AppColors.white,
      elevation: Sizes.buttonElevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadiusLg)),
      side: BorderSide(
        color: AppColors.primary,
      ),
      textStyle: AppTextThemes.lightTextTheme.bodyLarge,
      padding: EdgeInsets.symmetric(
        vertical: Sizes.md
      ),
    )
  );
}