part of 'add_new_task_bloc.dart';

@immutable
sealed class AddNewTaskEvent extends Equatable {}

final class AddNewTaskDataFetched extends AddNewTaskEvent {
  @override
  List<Object?> get props => [];
}

final class AddNewTaskNameChanged extends AddNewTaskEvent {
  final String taskName;
  AddNewTaskNameChanged(this.taskName);

  @override
  List<Object?> get props => [taskName];
}

final class AddNewTaskIconChanged extends AddNewTaskEvent {
  final IconData icon;
  AddNewTaskIconChanged(this.icon);

  @override
  List<Object?> get props => [icon];
}

final class AddNewTaskColorChanged extends AddNewTaskEvent {
  final Color color;
  AddNewTaskColorChanged(this.color);

  @override
  List<Object?> get props => [color];
}

final class AddNewTaskProjectSelected extends AddNewTaskEvent {
  final int? projectId;
  AddNewTaskProjectSelected(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

final class AddNewTaskTagsUpdated extends AddNewTaskEvent {
  final int tagId;
  AddNewTaskTagsUpdated(this.tagId);

  @override
  List<Object?> get props => [tagId];
}

final class AddNewTaskPomodorosChanged extends AddNewTaskEvent {
  final int pomodoros;
  AddNewTaskPomodorosChanged(this.pomodoros);

  @override
  List<Object?> get props => [pomodoros];
}

final class AddNewTaskSubmitted extends AddNewTaskEvent {
  @override
  List<Object?> get props => [];
}