part of 'recently_tasks_bloc.dart';

sealed class RecentlyTasksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class RecentlyTasksOnFetched extends RecentlyTasksEvent {}

/// Xoá task trong `state.tasks`
final class RecentlyTasksDeleteItem extends RecentlyTasksEvent {
  final int taskId;

  RecentlyTasksDeleteItem(this.taskId);
}

