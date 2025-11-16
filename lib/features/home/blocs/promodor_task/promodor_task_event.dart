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