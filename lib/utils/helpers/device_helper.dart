import 'package:flutter/services.dart';

/// Các hàm liên quan đến thiết bị
class DeviceHelper {
  /// xoay ngang
  static Future<void> rotateToLandscape () async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// xoay dọc
  static Future<void> rotateToPotrait () async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}