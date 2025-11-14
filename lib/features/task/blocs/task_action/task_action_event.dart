part of 'task_action_bloc.dart';

sealed class TaskActionEvent extends Equatable {
  const TaskActionEvent();

  @override
  List<Object> get props => [];
}

final class TaskActionOnDelete extends TaskActionEvent {
  final int taskId;

  const TaskActionOnDelete({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

final class TaskActionOnReset extends TaskActionEvent {
  @override
  List<Object> get props => [];
}