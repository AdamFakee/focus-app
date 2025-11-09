// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // --- MÀU CHUNG ---
  static const primary = Color(0xFFFF4649);
  static const primaryLight = Color(0xFFFEEEF1);
  static const secondary = Color(0xFF1791ED);
  static const orange = Color(0xFFFF9325);
  static const green = Color(0xFF47AC51);
  static const red = Color(0xFFD32F2F);
  static const warning = Color(0xFFF57C00); 
  static const gray = Color(0xFFBCBCBC); 
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

  // --- CÀI ĐẶT CHO TỪNG CHẾ ĐỘ ---
  static final light = _LightMode();
  static final dark = _DarkMode();
}


class _LightMode {
  // Bảng màu chính từ hình ảnh
  final Color primaryRed = const Color(0xFFFC4A47);
  final Color primaryRedDark = const Color(0xFFFF4649);
  final Color primaryBlue = const Color(0xFF1791ED);
  final Color primaryOrange = const Color(0xFFFF9325);
  final Color primaryGreen = const Color(0xFF47AC51);

  // Màu văn bản (Text)
  final Color textPrimary = const Color(0xFF35363A);
  final Color textSecondary = const Color(0xFF414043);

  // Màu nền (Background)
  final Color background = const Color(0xFFF6F6F6);
  final Color backgroundGray = const Color(0xFFFAFAFA);
  final Color backgroundSubtle = const Color(0xFFFFF0F0); // Một màu nền nhẹ nhàng

  // Màu cho các thành phần UI (Surface/Card)
  final Color surface = const Color(0xFFFFFFFF);
  final Color border = const Color(0xFFEEEEEE);  
}

class _DarkMode {
  final Color black = const Color(0xFF393939);
  final Color grayDark = const Color(0xFF494949);
  final Color white = const Color(0xFFFFFFFF);
  final Color gray = const Color(0xFF949494);
  final Color whiteDark = const Color(0xFFCCCCCC);
}
