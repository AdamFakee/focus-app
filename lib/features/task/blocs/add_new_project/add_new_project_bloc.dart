import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/project_repo.dart';
import 'package:focus_app/features/task/models/project_model.dart';

part 'add_new_project_event.dart';
part 'add_new_project_state.dart';

class AddNewProjectBloc extends Bloc<AddNewProjectEvent, AddNewProjectState> {
  final ProjectRepo _projectRepo;
  
  AddNewProjectBloc({
    required ProjectRepo projectRepo
  }) :
    _projectRepo = projectRepo, 
    super(const AddNewProjectState()) {
      on<AddNewProjectNameChanged>(_onNameChanged);
      on<AddNewProjectColorChanged>(_onColorChanged);
      on<AddNewProjectSubmmited>(_onSubmitted);
      on<AddNewProjectReset>(_onReset);
    }

  void _onNameChanged(AddNewProjectNameChanged event, Emitter emit) {
    emit(state.copyWith(
      projectName: event.projectName
    ));
  }

  void _onColorChanged(AddNewProjectColorChanged event, Emitter emit) {
    emit(state.copyWith(
      color: event.color
    ));
  }

  Future<void> _onSubmitted(AddNewProjectSubmmited event, Emitter emit) async {
    // Validation
    if(state.color == null) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Please fill color'
      ));
      return;
    }

    if(state.projectName == null) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Please fill project name'
      ));
      return;
    }
    // End validation

    // loading
    emit(state.copyWith(status: SubmissionStatus.loading));

    try {
      final newproject = ProjectModel(
        color: state.color!,
        createdAt: DateTime.now(),
        name: state.projectName!
      );

      await _projectRepo.createProject(newproject);


      emit(state.copyWith(
        status: SubmissionStatus.success, 
        isLoading: false
      ));

      // reset form
      add(AddNewProjectReset());

    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: e.toString(),
        isLoading: false
      ));
    }
  }

  void _onReset(AddNewProjectReset event, Emitter emit) {
    emit(AddNewProjectState());
  }
}
