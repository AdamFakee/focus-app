import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/themes/customs/text/text_theme.dart';

class OutlinedButtonThemes {
  static OutlinedButtonThemeData get darkTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: Size(double.infinity, 0),
      backgroundColor: AppColors.dark.black,
      foregroundColor: AppColors.dark.black,
      disabledBackgroundColor: AppColors.primary.withOpacity(0.8),
      disabledForegroundColor: AppColors.dark.black,
      elevation: Sizes.buttonElevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadiusLg)),
      side: BorderSide(
        color: AppColors.dark.whiteDark.withOpacity(0.6),
      ),
      textStyle: AppTextThemes.darkTextTheme.bodyLarge,
      padding: EdgeInsets.symmetric(
        vertical: Sizes.md
      )
    )
  );

  static OutlinedButtonThemeData get lightTheme => OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 0),
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.primary.withOpacity(0.8),
      disabledForegroundColor: AppColors.white,
      elevation: Sizes.buttonElevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadiusLg)),
      side: BorderSide(
        color: AppColors.dark.whiteDark,
      ),
      textStyle: AppTextThemes.lightTextTheme.bodyLarge,
      padding: EdgeInsets.symmetric(
        vertical: Sizes.md
      ),
    )
  );
}