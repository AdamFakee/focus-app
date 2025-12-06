import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Singleton pattern để dễ truy cập
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  /// Hàm tổng hợp để xin tất cả các quyền cần thiết khi mở app
  Future<bool> requestAllPermissions() async {
    bool notificationGranted = await requestNotificationPermission();
    bool batteryGranted = await requestBatteryOptimization();
    
    // Nếu dùng Schedule Exact Alarm (Android 12+)
    await requestScheduleExactAlarm();

    return notificationGranted && batteryGranted;
  }

  /// 1. Xin quyền Thông báo (Quan trọng cho Android 13+)
  Future<bool> requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    
    if (status.isDenied || status.isProvisional) {
      status = await Permission.notification.request();
    }
    
    if (status.isPermanentlyDenied) {
      // Mở cài đặt để user tự bật nếu họ đã từ chối vĩnh viễn
      await openAppSettings();
      return false;
    }
    
    return status.isGranted;
  }

  /// 2. Xin quyền bỏ qua tối ưu hóa Pin (Quan trọng cho Pomodoro)
  /// Nếu không có quyền này, Android sẽ kill background service sau vài phút tắt màn hình.
  Future<bool> requestBatteryOptimization() async {
    if (Platform.isAndroid) {
      PermissionStatus status = await Permission.ignoreBatteryOptimizations.status;
      if (status.isDenied) {
        status = await Permission.ignoreBatteryOptimizations.request();
      }
      return status.isGranted;
    }
    return true; // iOS không cần quyền này theo cách của Android
  }

  /// 3. Xin quyền Schedule Exact Alarm (Android 12+)
  /// Dùng nếu bạn schedule notification chính xác từng giây
  Future<void> requestScheduleExactAlarm() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 31) { // Android 12
         var status = await Permission.scheduleExactAlarm.status;
         if (status.isDenied) {
           await Permission.scheduleExactAlarm.request();
         }
      }
    }
  }
}