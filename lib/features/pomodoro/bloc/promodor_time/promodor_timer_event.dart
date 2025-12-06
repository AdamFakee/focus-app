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

///  chạy stream đếm thời gian
final class _PromodoroTimerEventOnStartTicked extends PromodorTimerEvent {}

/// thay đổi task làm việc
final class PromodorTimerEventOnChangeTask extends PromodorTimerEvent {
  final TaskModel newTask;
  const PromodorTimerEventOnChangeTask(this.newTask);

  @override
  List<Object> get props => [newTask];
}

/// task hiện tại đã được cập nhật thông số mới
final class PromodorTimerEventOnUpdateTask extends PromodorTimerEvent {
  final TaskModel updatedTask;
  const PromodorTimerEventOnUpdateTask(this.updatedTask);

  @override
  List<Object> get props => [updatedTask];
}

/// khởi tạo lại `bloc state`
final class PromodorTimerEventOnRefresh extends PromodorTimerEvent {}

/// nghỉ 5 phút hoặc bỏ qua thời gian nghỉ sau khi kết thúc 1 section
final class PromodorTimerEventOnBreakTime extends PromodorTimerEvent {}

/// đếm thời gian cho breakTime
final class _PromodoroTimerEventOnBreakTimeTicked extends PromodorTimerEvent {
  final int seconds;
  const _PromodoroTimerEventOnBreakTimeTicked({required this.seconds});

  @override
  List<Object> get props => [seconds];
}

/// huỷ breakTime
final class PromodorTimerEventOnCancleBreakTime extends PromodorTimerEvent {}