import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:focus_app/data/services/background/background_task_interface.dart';
import 'package:focus_app/data/services/background/tasks/pomodoro/pomodoro_background_listener.dart';

class PomodoroBackgroundTask implements BackgroundTaskInterface {
  @override
  void init() {}

  @override
  void onStart(ServiceInstance service) {
     if (service is AndroidServiceInstance) {
      service.setAsForegroundService();
    }

    //- Listener
    PomodoroBackgroundListener(service: service).initial();

  }

}