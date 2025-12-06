part of 'promodor_timer_bloc.dart';

enum PromodorTimerStatus { initial, running, paused, sectionEnded, breakTime, endBreakTime }

extension PromodorTimerStatusX on PromodorTimerStatus {
  bool get isInitial => this == PromodorTimerStatus.initial;
  bool get isRunning => this == PromodorTimerStatus.running;
  bool get isPaused => this == PromodorTimerStatus.paused;
  bool get isSectionEnded => this == PromodorTimerStatus.sectionEnded;
}


enum PomodorMode { work, shortBreak, longBreak }

class PromodorTimerState extends Equatable {
  /// remaining times (seconds) in current promodor section
  final int remaining;

  final bool isRunning;
  final PromodorTimerStatus status;

  // configuration defaults (in seconds)
  final int workDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final int longBreakInterval; // after how many pomodoros we trigger a long break

  final PomodorMode mode;

  /// total pomodoros completed in current section
  final int completedPomodoros;

  /// Tổng số pomodoro - target pomodoro
  final int totalPomodoros; 

  /// thời gian đã hoàn thành `current pomodoro section` (`Đơn vị: seconds`)
  final int secondsCompleteInCurrentSection;

  /// tính phần trăm thời gian đã hoàn thành trong `current pomodoro section`
  /// 
  /// tách ra như thế này để giao diện đỡ phải cập nhật liên tục theo từng giây thay đổi
  /// 
  /// 10 giây cập nhật 1 lần
  final double completeProgress;

  /// đếm thời gian nghỉ
  final int secondsInBreakTime;

  const PromodorTimerState({
    this.remaining = 0,
    this.isRunning = false,
    this.status = PromodorTimerStatus.initial,
    this.workDuration = 25 * 60,
    this.shortBreakDuration = 5 * 60,
    this.longBreakDuration = 15 * 60,
    this.longBreakInterval = 4,
    this.mode = PomodorMode.work,
    this.completedPomodoros = 3,
    this.totalPomodoros = 8,
    this.secondsCompleteInCurrentSection = 0,
    this.completeProgress = 0,
    this.secondsInBreakTime = 0
  });

  PromodorTimerState copyWith({
    int? remaining,
    bool? isRunning,
    PromodorTimerStatus? status,
    int? workDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? longBreakInterval,
    PomodorMode? mode,
    int? completedPomodoros,
    int? secondsCompleteInCurrentSection,
    int? totalPomodoros,
    double? completeProgress,
    int? secondsInBreakTime
  }) {
    return PromodorTimerState(
      remaining: remaining ?? this.remaining,
      isRunning: isRunning ?? this.isRunning,
      status: status ?? this.status,
      workDuration: workDuration ?? this.workDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
      longBreakInterval: longBreakInterval ?? this.longBreakInterval,
      mode: mode ?? this.mode,
      completedPomodoros: completedPomodoros ?? this.completedPomodoros,
      totalPomodoros: totalPomodoros ?? this.totalPomodoros,
      secondsCompleteInCurrentSection: secondsCompleteInCurrentSection ?? this.secondsCompleteInCurrentSection,
      completeProgress: completeProgress ?? this.completeProgress,
      secondsInBreakTime: secondsInBreakTime ?? this.secondsInBreakTime
    );
  }

  @override
  List<Object?> get props => [
        remaining,
        isRunning,
        status,
        workDuration,
        shortBreakDuration,
        longBreakDuration,
        longBreakInterval,
        mode,
        completedPomodoros,
        secondsCompleteInCurrentSection,
        totalPomodoros,
        completeProgress,
        secondsInBreakTime
      ];

  /// thời gian dạng "MM:SS"
  String get formatDuration {
    // Dùng phép chia lấy nguyên (integer division) để tính số phút
    final minutes = secondsCompleteInCurrentSection ~/ 60;
    
    // Dùng phép toán modulo để tính số giây còn lại
    final seconds = secondsCompleteInCurrentSection % 60;

    // padLeft(2, '0') đảm bảo rằng số luôn có 2 chữ số (ví dụ: 7 -> "07")
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  /// cứ `100(s)` sẽ cập nhật một lần
  double caculateCompletedProgress(int seconds) {
    if(seconds % 1 == 0) {
      final totalSecondsPerPomodoro = Globals.timePerPoromodor * 60;
      return seconds / totalSecondsPerPomodoro;
    }

    return completeProgress;
  }

  @override
  bool get stringify => true;
}
