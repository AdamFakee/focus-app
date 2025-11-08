import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/themes/customs/appbar_theme.dart';
import 'package:focus_app/utils/themes/customs/elevation_button_theme.dart';
import 'package:focus_app/utils/themes/customs/icon_theme.dart';
import 'package:focus_app/utils/themes/customs/outlined_button_theme.dart';
import 'package:focus_app/utils/themes/customs/text/text_theme.dart';
import 'package:focus_app/utils/themes/customs/input_decoration_theme.dart';


class AppThemes {
  /// dark-mode
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.dark.black,
      textTheme: AppTextThemes.darkTextTheme,
      appBarTheme: AppbarThemes.darkTheme,
      elevatedButtonTheme: ElevationButtonThemes.darkTheme,
      outlinedButtonTheme: OutlinedButtonThemes.darkTheme,
      inputDecorationTheme: InputDecorationThemes.darkTheme,
      iconTheme: IconThemes.darkMode
    );
  }

  /// light-mode
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.light.surface,
      textTheme: AppTextThemes.lightTextTheme,
      appBarTheme: AppbarThemes.lightTheme,
      elevatedButtonTheme: ElevationButtonThemes.lightTheme,
      outlinedButtonTheme: OutlinedButtonThemes.lightTheme,
      inputDecorationTheme: InputDecorationThemes.lightTheme,
      iconTheme: IconThemes.lightMode
    );
  }
}