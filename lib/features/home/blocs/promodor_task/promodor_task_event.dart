part of 'promodor_task_bloc.dart';

sealed class PromodorTaskEvent extends Equatable {
  const PromodorTaskEvent();

  @override
  List<Object> get props => [];
}

final class PromodorTaskEventOnSelectTask extends PromodorTaskEvent {
  final TaskModel task;

  const PromodorTaskEventOnSelectTask({required this.task});
  
  @override
  List<Object> get props => [task];
}

final class PromodorTaskEventOnAskChangeTask extends PromodorTaskEvent {
  final TaskModel penddingTask;

  const PromodorTaskEventOnAskChangeTask({required this.penddingTask});
  
  @override
  List<Object> get props => [penddingTask];
}

final class PromodorTaskEventOnConfirmChangeTask extends PromodorTaskEvent {}

final class PromodorTaskEventOnCancleChangeTask extends PromodorTaskEvent {}

/// khi `PromodorTimerBloc` có sự kiện nhất định như stop, end current section... => gửi thông số qua để cập nhật lại
class PromodorTaskEventOnUpdate extends PromodorTaskEvent {
  final int secondsCompleteInCurrentSection;
  const PromodorTaskEventOnUpdate({
    required this.secondsCompleteInCurrentSection
  });
}

class PromodorTaskEventOnRefresh extends PromodorTaskEvent {}