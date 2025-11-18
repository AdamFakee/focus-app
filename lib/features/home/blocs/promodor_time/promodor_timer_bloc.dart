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

  final PromodorTaskBloc _promodorTaskBloc;

  PromodorTimerBloc({
    required Ticker ticker,
    required PromodorTaskBloc promodorTaskBloc
  }) : 
    _ticker = ticker,
    _promodorTaskBloc = promodorTaskBloc,

    super(PromodorTimerState()) {
      on<PromodorTimerEventOnInitial>(_onInitial);
      on<PromodorTimerEventOnStart>(_onStart);
      on<PromodorTimerEventOnPause>(_onPause);
      on<PromodorTimerEventOnResume>(_onResume);
      on<PromodorTimerEventOnStop>(_onStop);
      on<PromodorTimerEventOnReset>(_onReset);
      on<_PromodoroTimerEventOnTicked>(_onPromodorTimerTicked);
      on<PromodorTimerEventOnChangeTask>(_onChangeTask);
      on<PromodorTimerEventOnUpdateTask>(_onUpdateTask);
      on<PromodorTimerEventOnRefresh>(_onRefresh);

      /// subscription to [PromodorTaskBloc]
      /// 
      /// task cập nhật => chạy hàm
      promodorSub = promodorTaskBloc.stream.where((taskState) => taskState.selectedTask != currentTask).listen((taskState) {
        if (taskState.selectedTask != null) {
          // // NẾU TIMER KHÔNG CHẠY, KHÔNG ĐƯỢC PHÉP TỰ Ý KHỞI ĐỘNG LẠI TIMER
          // // KHI TASK CHỈ ĐƠN THUẦN CẬP NHẬT DỮ LIỆU 
          // if (state.status.isInitial == false) {
          //   print('-update-');
          //   // Chỉ cập nhật lại currentTask để đồng bộ, không làm gì thêm.
          //   add(PromodorTimerEventOnInitial(task: taskState.selectedTask!));
          //   currentTask = taskState.selectedTask;
          //   return;
          // }

          //- true => selectask ở [taskState] đã được cập nhật thông số mới
          //- false => selectask đã được thay đổi sang task khác (check taskId)
          if(currentTask?.taskId == taskState.selectedTask?.taskId) {
            // add(PromodorTimerEventOnUpdateTask(taskState.selectedTask!));
            
            // cập nhật lại currentTask
            currentTask = taskState.selectedTask;
            return;
          }
          //- Chưa thực hiện đếm giờ lần nào
          if(currentTask == null) {
            add(PromodorTimerEventOnInitial(task: taskState.selectedTask!));
          } else {
            //- 2 tasks khác nhau => task đã được cập nhật hoàn toàn ( thay taskId )
            add(PromodorTimerEventOnChangeTask(taskState.selectedTask!));
          }
        }

        // cập nhật lại currentTask
        currentTask = taskState.selectedTask;
      });

    }

  void _onInitial(PromodorTimerEventOnInitial event, Emitter emit) {
    final task = event.task;
    final totalSecondsPerPomodoro = Globals.timePerPoromodor * 60;
    final double completeProgress = (task.secondsCompleteInCurrentSection / totalSecondsPerPomodoro).clamp(0, 1);
    emit(state.copyWith(
      totalPomodoros: task.totalPomodoros,
      secondsCompleteInCurrentSection: task.secondsCompleteInCurrentSection,
      completedPomodoros: task.completedPomodoros,
      completeProgress: completeProgress
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

    //- kiểm tra task được chọn tồn tại hay không
    if(currentTask == null) {
      print('------------- HIỂN THỊ THÔNG BÁO ------------');
      return;
    }
    print('-------------');
    print('currnet::: ${currentTask.toString()}');

    //- Cập nhật thông số
    add(PromodorTimerEventOnInitial(task: currentTask!));

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
    //- B1: huỷ stream cũ
    _tickerSubscription?.cancel();

    //- B2: quay về trạng thái khởi tạo
    emit(state.copyWith(
      status: PromodorTimerStatus.initial,
    ));

    //- B3: phát sự kiện để lưu thông tin vào database
    _promodorTaskBloc.add(PromodorTaskEventOnUpdate(secondsCompleteInCurrentSection: state.secondsCompleteInCurrentSection));
  }

  void _onReset(PromodorTimerEventOnReset event, Emitter emit) {
    // huỷ stream cũ
    _tickerSubscription?.cancel();

    // reset 
    emit(state.copyWith(
      secondsCompleteInCurrentSection: 0,
      completeProgress: 0,
      status: PromodorTimerStatus.initial
    ));
  }

  void _onPromodorTimerTicked(_PromodoroTimerEventOnTicked event, Emitter<PromodorTimerState> emit) {
    emit(state.copyWith(
      secondsCompleteInCurrentSection: event.seconds,
      completeProgress: state.caculateCompletedProgress(event.seconds),
    ));
  }

  void _onChangeTask(PromodorTimerEventOnChangeTask event, Emitter emit) {
    //- B1: stop timer
    add(PromodorTimerEventOnStop());

    //- B2: khởi tạo lại task
    add(PromodorTimerEventOnInitial(task: event.newTask));
  }

  void _onUpdateTask(PromodorTimerEventOnUpdateTask event, Emitter emit) {
    //- B1: huỷ stream
    _tickerSubscription?.cancel();

    //- B2: khởi tạo lại giá trị 
    add(PromodorTimerEventOnInitial(task: event.updatedTask));

    //- B3: tạo stream mới
    _tickerSubscription = _ticker
      .tick(
        limit: Globals.timePerPoromodor * 60 - state.secondsCompleteInCurrentSection, 
        startAt: state.secondsCompleteInCurrentSection,
      )
      .listen((seconds) => add(_PromodoroTimerEventOnTicked(seconds: seconds))); 
  }

  void _onRefresh(PromodorTimerEventOnRefresh event, Emitter emit) {
    emit(PromodorTimerState());
  }


  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

}
