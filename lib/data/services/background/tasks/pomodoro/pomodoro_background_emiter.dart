import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:focus_app/data/services/background/tasks/pomodoro/pomodoro_background_events.dart';

/// Phát ra các sự kiện lên quan đến pomodoro background task
class PomodoroBackgroundEmiter {
  // single ton
  static final PomodoroBackgroundEmiter _instance = PomodoroBackgroundEmiter._internal();

  PomodoroBackgroundEmiter._internal();

  factory PomodoroBackgroundEmiter() => _instance;


  final _service = FlutterBackgroundService();

  void start({
    required int startAt,
  }) {
    print('Start invoke');
    _service.invoke(
      PomodoroBackgroundEvents.pomodoroStart.name,
      {
        "startAt": startAt
      }
    );
  }

  void stop() {
    print('stop invoke');
    _service.invoke(
      PomodoroBackgroundEvents.pomodoroStop.name,
    );
  }
}