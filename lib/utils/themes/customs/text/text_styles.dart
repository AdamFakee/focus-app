import 'package:flutter/material.dart';

class AppTextStyles {
  static const String fontFamily = 'Be Vietnam Pro';

  /// Text style for body
  static const TextStyle bodyLg = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1 // xoá padding mặc định
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    height: 1
  );

  static const TextStyle bodyXs = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    height: 1
  );

  /// Text style for heading

  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1
  );
}
