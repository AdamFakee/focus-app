import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Size getSize(double percent) => Size(
    MediaQuery.of(this).size.width * percent,
    MediaQuery.of(this).size.height * percent
  );
  double screenHeight() => MediaQuery.of(this).size.height;
  double screenWidht() => MediaQuery.of(this).size.width;

  bool isDarkMode() => Theme.of(this).brightness == Brightness.dark;

  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;
}