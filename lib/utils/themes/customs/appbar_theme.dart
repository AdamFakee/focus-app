import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/themes/customs/text/text_theme.dart';

class AppbarThemes {
  static AppBarTheme get darkTheme => AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(size: 22, color: AppColors.dark.white, weight: 20),
    actionsPadding: EdgeInsets.only(right: Sizes.md),
    titleSpacing: Sizes.md,
    scrolledUnderElevation: 0,
    titleTextStyle: AppTextThemes.darkTextTheme.displayLarge,
    actionsIconTheme: IconThemeData(size: 24, color: AppColors.primary)
  );

  static AppBarTheme get lightTheme => AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(size: 22, color: AppColors.black, weight: 20),
    titleSpacing: Sizes.md,
    actionsPadding: EdgeInsets.only(right: Sizes.md),
    scrolledUnderElevation: 0,
    titleTextStyle: AppTextThemes.darkTextTheme.displayLarge,
    actionsIconTheme: IconThemeData(size: 24, color: AppColors.primary)
  );
}