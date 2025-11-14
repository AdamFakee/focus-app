import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';

part 'task_action_event.dart';
part 'task_action_state.dart';

class TaskActionBloc extends Bloc<TaskActionEvent, TaskActionState> {
  final TaskRepo _taskRepo;

  TaskActionBloc({
    required TaskRepo taskRepo
  }) : 
    _taskRepo = taskRepo,
    super(TaskActionState()) {
      on<TaskActionOnDelete>(_onDelete);
      on<TaskActionOnReset>(_onReset);
    }

  _onDelete(TaskActionOnDelete event, Emitter emit) async {
    try {
      await _taskRepo.deleteTask(event.taskId);

      emit(state.copyWith(
        status: SubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  _onReset(TaskActionOnReset event, Emitter emit) async {
    emit(state.copyWith(
      status: SubmissionStatus.initial,
      errorMessage: null
    ));
  }
}
