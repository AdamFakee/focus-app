part of 'delete_project_bloc.dart';

sealed class DeleteProjectEvent extends Equatable {
  const DeleteProjectEvent();
}

final class DeleteProjectSubmitted extends DeleteProjectEvent {
  final int projectId;

  const DeleteProjectSubmitted(this.projectId);

  @override
  List<Object> get props => [projectId];
}