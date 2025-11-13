part of 'add_new_project_bloc.dart';

sealed class AddNewProjectEvent extends Equatable {}

final class AddNewProjectNameChanged extends AddNewProjectEvent {
  final String projectName;

  AddNewProjectNameChanged({required this.projectName});

  @override
  List<Object> get props => [projectName];
}

final class AddNewProjectColorChanged extends AddNewProjectEvent {
  final Color color;

  AddNewProjectColorChanged({required this.color});

  @override
  List<Object> get props => [color];
}

final class AddNewProjectSubmmited extends AddNewProjectEvent {
  @override
  List<Object?> get props => [];
}

final class AddNewProjectReset extends AddNewProjectEvent {
  @override
  List<Object?> get props => [];
}