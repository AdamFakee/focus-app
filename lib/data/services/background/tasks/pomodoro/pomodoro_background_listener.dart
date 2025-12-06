
import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:focus_app/data/services/background/tasks/pomodoro/pomodoro_background_events.dart';
import 'package:focus_app/data/services/notifications/pomodoro_notification_service.dart';
import 'package:focus_app/features/pomodoro/bloc/promodor_time/ticker.dart';
import 'package:focus_app/utils/const/global.dart';


/// Lắng nghe các sự kiện lên quan đến pomodoro background task
class PomodoroBackgroundListener {
  // DÙNG SINGLE-TON Ở ĐÂY ĐỂ TRÁNH MEMORY-LEAK
  // CÓ THỂ THỬ DÙNG CONSTRUCTOR CMT PHÍA DƯỚI ĐỂ THẤY MEMORY-LEAK
  // LÝ DO: không hiểu lắm

  // single ton
  static PomodoroBackgroundListener? _instance;

  PomodoroBackgroundListener._(this._service);

  factory PomodoroBackgroundListener({required ServiceInstance service}) {
    return _instance ??= PomodoroBackgroundListener._(service);
  }

  // PomodoroBackgroundListener({
  //   required ServiceInstance service
  // }): _service = service;


  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  /// stream tính thời gian nghỉ
  StreamSubscription<int>? _breakTimeTickerSubscription;

  final _notification = PomodoroNotificationService();
  final ServiceInstance _service;


  /// khởi tạo các background_listener
  void initial() {
    _start();
  }

  void _start() {
    _service.on(PomodoroBackgroundEvents.pomodoroStart.name).listen(
      (data) {
        if(data == null) return;

        final startAt = data['startAt'] as int;
        
        _runFocusSession(startAt); 
      }
    );
  }

  /// Bắt đầu chạy focus 
  void _runFocusSession(int startAt) {
    //- B1: huỷ stream cũ nếu có
    _tickerSubscription?.cancel();
    _breakTimeTickerSubscription?.cancel();


    //- B2: chạy stream mới
    _tickerSubscription = _ticker
      .tick(
        // limit: Globals.timePerPoromodor * 60 - startAt, 
        startAt: startAt,
        limit: 5
      )
      .listen(
        (seconds) {
          _updateNotification(seconds);
        },
        onDone: () {
          _breakTime();
        },
      );  
  }


  void _updateNotification(int seconds, [String currentMode = 'Focus']) {
    final displayTime = _formatDuration(seconds);
    _notification.showProgressNotification(displayTime: displayTime , currentMode: currentMode);
  }

  void _breakTime() {
    //- B1: Huỷ ticker hiện tại
    _tickerSubscription?.cancel();
    _breakTimeTickerSubscription?.cancel();

    _breakTimeTickerSubscription = Ticker().tick(
      limit: Globals.breakTimePerPoromodor, 
      startAt: 0
    ).listen(
      (seconds) {
        _updateNotification(seconds, 'Break Time');
      },
      onDone: () {
        _runFocusSession(0);
      },
    );
  }

  /// thời gian dạng "MM:SS"
  String _formatDuration(int currentSeconds) {
    // Dùng phép chia lấy nguyên (integer division) để tính số phút
    final minutes = currentSeconds ~/ 60;
    
    // Dùng phép toán modulo để tính số giây còn lại
    final seconds = currentSeconds % 60;

    // padLeft(2, '0') đảm bảo rằng số luôn có 2 chữ số (ví dụ: 7 -> "07")
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}

