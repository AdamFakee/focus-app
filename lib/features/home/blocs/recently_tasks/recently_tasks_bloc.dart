import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';
import 'package:focus_app/features/task/models/task_model.dart';
import 'package:focus_app/utils/const/global.dart';

part 'recently_tasks_event.dart';
part 'recently_tasks_state.dart';

class RecentlyTasksBloc extends Bloc<RecentlyTasksEvent, RecentlyTasksState> {
  final TaskRepo _taskRepo;

  RecentlyTasksBloc({
    required TaskRepo taskRepo
  }) : 
    _taskRepo = taskRepo,
    super(RecentlyTasksState()) {
      on<RecentlyTasksOnFetched>(_onFetched);
      on<RecentlyTasksDeleteItem>(_onDeleteItem);
    }

  Future<void> _onFetched(
    RecentlyTasksOnFetched event,
    Emitter emit,
  ) async {
    // loading
    emit(state.copyWith(status: SubmissionStatus.loading));

    try {
      final tasks = await _taskRepo.getAll(
        limit: Globals.limitInSmallerPagination,
        status: TaskStatus.active
      );

      emit(state.copyWith(
        status: SubmissionStatus.initial,
        tasks: tasks 
      ));

    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onDeleteItem(RecentlyTasksDeleteItem event, Emitter emit) {
    final updatedTasks = state.tasks.where((t) => t.taskId != event.taskId).toList();
  emit(state.copyWith(tasks: updatedTasks));
  }

}
