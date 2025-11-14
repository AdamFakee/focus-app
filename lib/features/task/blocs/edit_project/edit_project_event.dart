part of 'edit_project_bloc.dart';

@immutable
sealed class EditProjectEvent extends Equatable {
  const EditProjectEvent();
}

final class EditProjectFetched extends EditProjectEvent {
  final int projectId;
  const EditProjectFetched(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

final class EditProjectNameChanged extends EditProjectEvent {
  final String projectName;
  const EditProjectNameChanged(this.projectName);

  @override
  List<Object?> get props => [projectName];
}

final class EditProjectColorChanged extends EditProjectEvent {
  final Color color;
  const EditProjectColorChanged(this.color);

  @override
  List<Object?> get props => [color];
}

final class EditProjectSubmitted extends EditProjectEvent {
  const EditProjectSubmitted();

  @override
  List<Object?> get props => [];
}

final class EditProjectReset extends EditProjectEvent {
  const EditProjectReset();

  @override
  List<Object?> get props => [];
}
