import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/project_repo.dart';
import 'package:focus_app/features/task/data/repos/tag_repo.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';
import 'package:focus_app/features/task/models/project_model.dart';
import 'package:focus_app/features/task/models/tag_model.dart';
import 'package:focus_app/features/task/models/task_model.dart';

part 'add_new_task_event.dart';
part 'add_new_task_state.dart';

class AddNewTaskBloc extends Bloc<AddNewTaskEvent, AddNewTaskState> {

  final TaskRepo _taskRepo;
  final ProjectRepo _projectRepo;
  final TagRepo _tagRepo;

  AddNewTaskBloc({
    required TaskRepo taskRepo,
    required ProjectRepo projectRepo,
    required TagRepo tagRepo
  }) :   
    _taskRepo = taskRepo,
    _projectRepo = projectRepo,
    _tagRepo = tagRepo,
    super(AddNewTaskState()) {
      on<AddNewTaskDataFetched>(_onDataFetched);
      on<AddNewTaskNameChanged>(_onNameChanged);
      on<AddNewTaskIconChanged>(_onIconChanged);
      on<AddNewTaskColorChanged>(_onColorChanged);
      on<AddNewTaskProjectSelected>(_onProjectSelected);
      on<AddNewTaskTagsUpdated>(_onTagsUpdated);
      on<AddNewTaskPomodorosChanged>(_onPomodorosChanged);
      on<AddNewTaskSubmitted>(_onSubmitted);
    }

  Future<void> _onDataFetched(AddNewTaskDataFetched event, Emitter<AddNewTaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final projects = await _projectRepo.getAll();
      final tags = await _tagRepo.getAll();

      emit(state.copyWith(
        projects: projects,
        tags: tags
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: e.toString()
      ));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
  
  // Handler cho các thay đổi trên form - rất đơn giản nhờ copyWith
  void _onNameChanged(AddNewTaskNameChanged event, Emitter<AddNewTaskState> emit) {
    emit(state.copyWith(taskName: event.taskName));
  }

  void _onIconChanged(AddNewTaskIconChanged event, Emitter<AddNewTaskState> emit) {
    emit(state.copyWith(icon: event.icon));
  }
  
  void _onColorChanged(AddNewTaskColorChanged event, Emitter<AddNewTaskState> emit) {
    emit(state.copyWith(color: event.color));
  }

  void _onProjectSelected(AddNewTaskProjectSelected event, Emitter<AddNewTaskState> emit) {
    emit(state.copyWith(projectId: event.projectId));
  }

  void _onTagsUpdated(AddNewTaskTagsUpdated event, Emitter<AddNewTaskState> emit) {
    emit(state.copyWith(tagIds: event.tagIds));
  }
  
  void _onPomodorosChanged(AddNewTaskPomodorosChanged event, Emitter<AddNewTaskState> emit) {
    emit(state.copyWith(pomodoros: event.pomodoros));
  }

  // Handler khi người dùng nhấn nút Lưu
  Future<void> _onSubmitted(AddNewTaskSubmitted event, Emitter<AddNewTaskState> emit) async {
    // Validation
    if (state.taskName.isEmpty) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Please fill task name'
      ));
      return;
    }

    if (state.icon == null) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Please fill icon'
      ));
      return;
    }

    if (state.color == null) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Please fill color'
      ));
      return;
    }

    emit(state.copyWith(status: SubmissionStatus.loading));

    try {
      final newTask = TaskModel(
        taskName: state.taskName,
        icon: state.icon!,
        color: state.color!,
        totalPomodoros: state.pomodoros,
        completedPomodoros: 0,
        projectId: state.projectId,
        tagIds: state.tagIds,
        createdAt: DateTime.now(),
        durationSpent: Duration.zero,
      );

      await _taskRepo.createTask(newTask);


      emit(state.copyWith(status: SubmissionStatus.success));

    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: e.toString()
      ));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
