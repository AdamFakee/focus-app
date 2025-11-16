import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/models/task_model.dart';

part 'promodor_task_event.dart';
part 'promodor_task_state.dart';

class PromodorTaskBloc extends Bloc<PromodorTaskEvent, PromodorTaskState> {
  PromodorTaskBloc() : super(PromodorTaskState()) {
    on<PromodorTaskEventOnSelectTask>(_onSelectTask);
    on<PromodorTaskEventOnAskChangeTask>(_onAskChangeTask);
    on<PromodorTaskEventOnConfirmChangeTask>(_onConfirmChangeTask);
    on<PromodorTaskEventOnCancleChangeTask>(_onCancleChangeTask);
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
}
