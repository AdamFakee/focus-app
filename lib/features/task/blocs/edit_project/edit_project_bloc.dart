import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/project_repo.dart';
import 'package:focus_app/features/task/models/project_model.dart';

part 'edit_project_event.dart';
part 'edit_project_state.dart';

class EditProjectBloc extends Bloc<EditProjectEvent, EditProjectState> {
  final ProjectRepo _projectRepo;

  EditProjectBloc({
    required ProjectRepo projectRepo,
  })  : _projectRepo = projectRepo,
        super(const EditProjectState()) {
    on<EditProjectFetched>(_onFetched);
    on<EditProjectNameChanged>(_onNameChanged);
    on<EditProjectColorChanged>(_onColorChanged);
    on<EditProjectSubmitted>(_onSubmitted);
    on<EditProjectReset>(_onReset);
  }

  /// Fetch project by ID
  Future<void> _onFetched(EditProjectFetched event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final project = await _projectRepo.getProjectById(event.projectId);
      emit(state.copyWith(
        isLoading: false,
        projectId: project.projectId,
        projectName: project.name,
        color: project.color,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        status: SubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onNameChanged(EditProjectNameChanged event, Emitter emit) {
    emit(state.copyWith(projectName: event.projectName));
  }

  void _onColorChanged(EditProjectColorChanged event, Emitter emit) {
    emit(state.copyWith(color: event.color));
  }

  Future<void> _onSubmitted(EditProjectSubmitted event, Emitter emit) async {
    // Validation
    if (state.projectName == null || state.projectName!.isEmpty) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Missing project name',
      ));
      return;
    }

    if (state.color == null) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Missing color',
      ));
      return;
    }
    // End validation

    emit(state.copyWith(
      status: SubmissionStatus.loading,
      isLoading: true,
    ));

    try {
      final updatedproject = ProjectModel(
        projectId: state.projectId,
        name: state.projectName!,
        color: state.color!,
        createdAt: DateTime.now(),
      );

      await _projectRepo.updateProject(updatedproject);

      emit(state.copyWith(
        status: SubmissionStatus.success,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onReset(EditProjectReset event, Emitter emit) {
    emit(const EditProjectState());
  }
}
