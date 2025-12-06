import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class BaseNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get plugin => _flutterLocalNotificationsPlugin;

  /// Hàm khởi tạo chung cho mọi service
  Future<void> initialize() async {
    // 1. Cấu hình Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); 

    // 2. Cấu hình iOS
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    // 3. Tổng hợp
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );

    await createNotificationChannels();
  }

  Future<void> createNotificationChannels();

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required AndroidNotificationDetails androidDetails,
    String? payload,
  }) async {
    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();
    
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Hàm hủy thông báo theo ID
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Hàm hủy tất cả
  Future<void> cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Callback khi user tap vào thông báo (Có thể override ở class con nếu cần)
  void onNotificationTap(NotificationResponse notificationResponse) {
    // Logic mặc định: In ra payload
    print('Notification Tapped: ${notificationResponse.payload}');
  }
}