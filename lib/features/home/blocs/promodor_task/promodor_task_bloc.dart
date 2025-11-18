import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';
import 'package:focus_app/features/task/models/task_model.dart';
import 'package:focus_app/utils/const/global.dart';

part 'promodor_task_event.dart';
part 'promodor_task_state.dart';

class PromodorTaskBloc extends Bloc<PromodorTaskEvent, PromodorTaskState> {
  final TaskRepo _taskRepo;

  PromodorTaskBloc({
    required TaskRepo taskRepo
  }) : 
    _taskRepo = taskRepo,

    super(PromodorTaskState()) {
      on<PromodorTaskEventOnSelectTask>(_onSelectTask);
      on<PromodorTaskEventOnAskChangeTask>(_onAskChangeTask);
      on<PromodorTaskEventOnConfirmChangeTask>(_onConfirmChangeTask);
      on<PromodorTaskEventOnCancleChangeTask>(_onCancleChangeTask);
      on<PromodorTaskEventOnUpdate>(_onUpdate);
      on<PromodorTaskEventOnRefresh>(_onRefresh);
    }

  void _onSelectTask(PromodorTaskEventOnSelectTask event, Emitter emit) {
    add(PromodorTaskEventOnAskChangeTask(
      penddingTask: event.task,
    ));
  }

  void _onAskChangeTask(PromodorTaskEventOnAskChangeTask event, Emitter emit) {
    emit(state.copyWith(
      penddingTask: event.penddingTask,
      status: PromodorTaskStatus.askConfirmChangeTask
    ));
  }

  void _onConfirmChangeTask(PromodorTaskEventOnConfirmChangeTask event, Emitter emit) {
    emit(state.copyWith(
      selectedTask: state.penddingTask,
      penddingTask: null,
      status: PromodorTaskStatus.initial
    ));
  }

  void _onCancleChangeTask(PromodorTaskEventOnCancleChangeTask event, Emitter emit) {
    emit(state.copyWith(
      status: PromodorTaskStatus.initial,
      penddingTask: null
    ));
  }

  void _onUpdate(PromodorTaskEventOnUpdate event, Emitter emit) async {
    final task = state.selectedTask;
    if (task == null) return;

    /// ví dụ: tổng số thời gian cần để hoàn thành 1 promodor = 10, nếu [secondsCompleteInCurrentSection] = 10 => tăng [newCompletedPomodoros] lên một đơn vị
    final isFullPomodoro = event.secondsCompleteInCurrentSection == Globals.timePerPoromodor * 60;

    final newCompletedPomodoros = isFullPomodoro
        ? (task.completedPomodoros + 1).clamp(0, task.totalPomodoros)
        : task.completedPomodoros;  
    final newDurantionSeconds = task.durationSpent.inSeconds +  event.secondsCompleteInCurrentSection; 

    final updatedTask = task.copyWith(
      completedPomodoros: newCompletedPomodoros,
      durationSpent: Duration(seconds: newDurantionSeconds),
      createdAt: DateTime.now()
    );

    try {
      await _taskRepo.updateTask(updatedTask);

      emit(state.copyWith(selectedTask: updatedTask));
    } catch (_) {
      emit(state.copyWith(status: PromodorTaskStatus.failue));
    }

    
  }

  void _onRefresh(PromodorTaskEventOnRefresh event, Emitter emit) {
    emit(PromodorTaskState());
  }
}
