import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:focus_app/data/services/notifications/config/notification_constants.dart'; 
import 'base_notification_service.dart';

class PomodoroNotificationService extends BaseNotificationService {
  // Singleton pattern
  static final PomodoroNotificationService _instance = PomodoroNotificationService._internal();
  factory PomodoroNotificationService() => _instance;
  PomodoroNotificationService._internal();

  @override
  Future<void> createNotificationChannels() async {
    final androidPlugin = plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(AndroidNotificationChannel(
        NotificationConstants.pomodoro.channelId, 
        NotificationConstants.pomodoro.channelName,
        description: 'Thông báo Pomodoro',
        importance: Importance.max,
        playSound: true,        
        enableVibration: true,     
      ));
    }
  }

  /// Hiển thị thông báo tiến độ (Chạy mỗi giây)
  Future<void> showProgressNotification({required String displayTime, required String currentMode}) async {
    final androidDetails = AndroidNotificationDetails(
      NotificationConstants.pomodoro.channelId.toString(),
      NotificationConstants.pomodoro.channelName,
      importance: Importance.low, 
      priority: Priority.low,
      playSound: false,               // Không phát tiếng mỗi giây
      enableVibration: false,         // Không rung mỗi giây
      onlyAlertOnce: true,            
      ongoing: true,                 // Không cho user quẹt tắt
      autoCancel: false,
      showWhen: false,
      
      actions: [
        const AndroidNotificationAction('pause_action', 'Tạm dừng'),
        const AndroidNotificationAction('stop_action', 'Kết thúc'),
      ],
    );

    await showNotification(
      id: NotificationConstants.pomodoro.notificationId,
      title: currentMode,
      body: displayTime,
      androidDetails: androidDetails,
    );
  }

  /// Hiển thị thông báo khi hết giờ
  Future<void> showFinishedNotification({required String message}) async {
    final androidDetails = AndroidNotificationDetails(
      NotificationConstants.pomodoro.channelId,
      NotificationConstants.pomodoro.channelName,
      importance: Importance.max,    
      priority: Priority.high,
      playSound: true,           
      enableVibration: true,        
      onlyAlertOnce: false,           
      fullScreenIntent: true,      
    );

    await showNotification(
      id: NotificationConstants.pomodoro.notificationId,
      title: "Break Time",
      body: message,
      androidDetails: androidDetails,
      payload: 'timer_finished',
    );
  }
}