import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:focus_app/data/services/background/background_task_manager.dart';
import 'package:focus_app/data/services/background/tasks/pomodoro/pomodoro_background_task.dart';
import 'package:focus_app/data/services/notifications/pomodoro_notification_service.dart';

class BackgroundService {
  Future<void> init() async {
    final service = FlutterBackgroundService();

    // init notification
    await PomodoroNotificationService().initialize();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
          // SỬA DÒNG NÀY: Dùng chung ID với bên NotificationService
        notificationChannelId: 'Pomodoro', // Phải khớp với NotificationConstants.pomodoro.channelId
        
        initialNotificationTitle: 'Focus App', // Sửa lại title cho hợp lý
        initialNotificationContent: 'Running in background...',
        foregroundServiceNotificationId: 888, // ID này nên khác với ID của pomodoro (1) để tránh conflict
        // Dòng này gây crash nếu không có quyền Location
        foregroundServiceTypes: [AndroidForegroundType.location], 
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
      ),
    );
    await service.startService();
  }
}


@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // DartPluginRegistrant.ensureInitialized(); 


  final backgroundTasksManager = BackgroundTaskManager();
  
  backgroundTasksManager.register(PomodoroBackgroundTask());

  backgroundTasksManager.startAll(service);
}