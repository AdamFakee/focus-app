import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/home/blocs/promodor_task/promodor_task_bloc.dart';
import 'package:focus_app/features/home/blocs/promodor_time/test.dart';
import 'package:focus_app/features/task/models/task_model.dart';
import 'package:focus_app/utils/const/global.dart';

part 'promodor_timer_event.dart';
part 'promodor_timer_state.dart';


class PromodorTimerBloc extends Bloc<PromodorTimerEvent, PromodorTimerState> {
  late final StreamSubscription promodorSub;

  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TaskModel? currentTask;

  PromodorTimerBloc({
    required Ticker ticker,
    required PromodorTaskBloc promodorTaskBloc
  }) : 
    _ticker = ticker,

    super(PromodorTimerState()) {
      on<PromodorTimerEventOnInitial>(_onInitial);
      on<PromodorTimerEventOnStart>(_onStart);
      on<PromodorTimerEventOnPause>(_onPause);
      on<PromodorTimerEventOnResume>(_onResume);
      on<PromodorTimerEventOnStop>(_onStop);
      on<PromodorTimerEventOnReset>(_onReset);
      on<_PromodoroTimerEventOnTicked>(_onPromodorTimerTicked);

      /// subscription to [PromodorTaskBloc]
      /// 
      /// task cập nhật => chạy hàm
      promodorSub = promodorTaskBloc.stream.where((taskState) => taskState.selectedTask != currentTask).listen((taskState) {

        if (taskState.selectedTask != null) {
          //- Chưa thực hiện đếm giờ lần nào
          if(currentTask == null) {
            add(PromodorTimerEventOnInitial(task: taskState.selectedTask!));
          } else {
            add(PromodorTimerEventOnStop());
          }
        }

        // cập nhật lại currentTask
        currentTask = taskState.selectedTask;
      });

    }

  void _onInitial(PromodorTimerEventOnInitial event, Emitter emit) {
    emit(state.copyWith(
      totalPomodoros: event.task.totalPomodoros,
      secondsCompleteInCurrentSection: event.task.secondsCompleteInCurrentSection,
      completedPomodoros: event.task.completedPomodoros
    ));
  }

  void _onStart(PromodorTimerEventOnStart event, Emitter<PromodorTimerState> emit) {
    // đang chạy => dừng lại
    if(state.status.isRunning) {
      add(PromodorTimerEventOnPause());
      return;
    }

    // dừng lại => tiếp tục
    if(state.status.isPaused) {
      add(PromodorTimerEventOnResume());
      return;
    }

    emit(state.copyWith(status: PromodorTimerStatus.running));
    
    // Hủy subscription cũ nếu có
    _tickerSubscription?.cancel();

    // đăng ký stream mới
    _tickerSubscription = _ticker
        .tick(
          limit: Globals.timePerPoromodor * 60 - state.secondsCompleteInCurrentSection, 
          startAt: state.secondsCompleteInCurrentSection,
        )
        .listen((seconds) => add(_PromodoroTimerEventOnTicked(seconds: seconds))); 
  }

  void _onPause(PromodorTimerEventOnPause event, Emitter emit) {
    emit(state.copyWith(
      status: PromodorTimerStatus.paused
    ));

    _tickerSubscription?.pause();
  }

  void _onResume(PromodorTimerEventOnResume event, Emitter emit) {
    emit(state.copyWith(
      status: PromodorTimerStatus.running
    ));

    _tickerSubscription?.resume();
  }

  void _onStop(PromodorTimerEventOnStop event, Emitter emit) {
    print('stop');
  }

  void _onReset(PromodorTimerEventOnReset event, Emitter emit) {
    // huỷ stream cũ
    _tickerSubscription?.cancel();

    // reset 
    emit(state.copyWith(
      secondsCompleteInCurrentSection: 0,
      completeProgress: 0
    ));

    // đăng ký stream mới
    _tickerSubscription = _ticker
      .tick(
        limit: Globals.timePerPoromodor * 60 - state.secondsCompleteInCurrentSection, 
        startAt: state.secondsCompleteInCurrentSection,
      )
      .listen((seconds) => add(_PromodoroTimerEventOnTicked(seconds: seconds))); 
  }

  void _onPromodorTimerTicked(_PromodoroTimerEventOnTicked event, Emitter<PromodorTimerState> emit) {
    emit(state.copyWith(
      secondsCompleteInCurrentSection: event.seconds,
      completeProgress: state.caculateCompletedProgress(event.seconds),
    ));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

}
