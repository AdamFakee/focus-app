part of 'promodor_timer_bloc.dart';

sealed class PromodorTimerEvent extends Equatable {
  const PromodorTimerEvent();

  @override
  List<Object> get props => [];
}

/// khởi tạo
final class PromodorTimerEventOnInitial extends PromodorTimerEvent {
  final TaskModel task;

  const PromodorTimerEventOnInitial({required this.task});

  @override
  List<Object> get props => [task];
}


/// bắt đầu đếm thời gian
final class PromodorTimerEventOnStart extends PromodorTimerEvent {}

/// tạm dừng đếm thời gian
final class PromodorTimerEventOnPause extends PromodorTimerEvent {}

/// tiếp tục đếm thời gian sau khi tạm dừng
final class PromodorTimerEventOnResume extends PromodorTimerEvent {}

/// dừng hoàn toàn pomodoros
final class PromodorTimerEventOnStop extends PromodorTimerEvent {}

/// ví dụ: đang chạy promodor thứ nhất. Chạy được 20 phút => Reset thời gian chạy về 0 và chạy lại
final class PromodorTimerEventOnReset extends PromodorTimerEvent {}

/// ví dụ: đang chạy promodor thứ nhất. Chạy được 20 phút => Sang promodor thứ 2
final class PromodorTimerEventOnSkipSection extends PromodorTimerEvent {}

/// Kết thúc promodor thứ nhất => dùng sự kiện này để lưu data và bắt đầu tạo break-time & chuẩn bị chạy promodor thứ 2
final class PromodorTimerEventOnEndSection extends PromodorTimerEvent {}


/// thay đổi PromodorMode (work / shortBreak / longBreak)
final class PromodorTimerEventOnChangeMode extends PromodorTimerEvent {
  final PomodorMode mode;
  const PromodorTimerEventOnChangeMode(this.mode);

  @override
  List<Object> get props => [mode];
}

/// đếm thời gian
final class _PromodoroTimerEventOnTicked extends PromodorTimerEvent {
  final int seconds;
  const _PromodoroTimerEventOnTicked({required this.seconds});

  @override
  List<Object> get props => [seconds];
}
