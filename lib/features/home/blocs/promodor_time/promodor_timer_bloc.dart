import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/home/blocs/audio/audio_bloc.dart';
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

  /// stream tính thời gian nghỉ
  StreamSubscription<int>? _breakTimeTickerSubscription;

  TaskModel? currentTask;

  final AudioBloc _audioBloc;

  final PromodorTaskBloc _promodorTaskBloc;

  PromodorTimerBloc({
    required Ticker ticker,
    required PromodorTaskBloc promodorTaskBloc,
    required AudioBloc audioBloc
  }) : 
    _ticker = ticker,
    _promodorTaskBloc = promodorTaskBloc,
    _audioBloc = audioBloc,

    super(PromodorTimerState()) {
      on<PromodorTimerEventOnInitial>(_onInitial);
      on<PromodorTimerEventOnStart>(_onStart);
      on<PromodorTimerEventOnPause>(_onPause);
      on<PromodorTimerEventOnResume>(_onResume);
      on<PromodorTimerEventOnStop>(_onStop);
      on<PromodorTimerEventOnReset>(_onReset);
      on<_PromodoroTimerEventOnTicked>(_onPromodorTimerTicked);
      on<_PromodoroTimerEventOnStartTicked>(_onStartTicked);
      on<PromodorTimerEventOnChangeTask>(_onChangeTask);
      on<PromodorTimerEventOnUpdateTask>(_onUpdateTask);
      on<PromodorTimerEventOnRefresh>(_onRefresh);
      on<PromodorTimerEventOnSkipSection>(_onSkipSection);
      on<PromodorTimerEventOnEndSection>(_onEndSection);
      on<PromodorTimerEventOnBreakTime>(_onBreakTime);
      on<_PromodoroTimerEventOnBreakTimeTicked>(_onBreakTimeTicked);
      on<PromodorTimerEventOnCancleBreakTime>(_onCancleBreakTime);

      /// subscription to [PromodorTaskBloc]
      /// 
      /// task cập nhật => chạy hàm
      promodorSub = promodorTaskBloc.stream.where((taskState) => taskState.selectedTask != currentTask).listen((taskState) {
        if (taskState.selectedTask != null) {
          //- true => selectask ở [taskState] đã được cập nhật thông số mới
          //- false => selectask đã được thay đổi sang task khác (check taskId)
          if(currentTask?.taskId == taskState.selectedTask?.taskId) {
            
            // cập nhật lại currentTask
            currentTask = taskState.selectedTask;
            add(PromodorTimerEventOnInitial(task: taskState.selectedTask!));
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


    emit(state.copyWith(status: PromodorTimerStatus.running));
    
    // Hủy subscription cũ nếu có
    _tickerSubscription?.cancel();

    // play audio
    _audioBloc.add(AudioEventOnPlayAudio());

    // đăng ký stream mới
    add(_PromodoroTimerEventOnStartTicked());
  }

  void _onPause(PromodorTimerEventOnPause event, Emitter emit) {
    //- B1: thay đổi state
    emit(state.copyWith(
      status: PromodorTimerStatus.paused
    ));

    //- B2: pause audio
    _audioBloc.add(AudioEventOnPauseAudio());

    //- B3: pause timer
    _tickerSubscription?.pause();
  }

  void _onResume(PromodorTimerEventOnResume event, Emitter emit) {
    //- B1: thay đổi trạng thái state
    emit(state.copyWith(
      status: PromodorTimerStatus.running
    ));

    //- B2: resume audio
    _audioBloc.add(AudioEventOnResumeAudio());

    //- B3: resume stream
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

    //- B4: stop audio
    _audioBloc.add(AudioEventOnStopAudio());

  }

  void _onReset(PromodorTimerEventOnReset event, Emitter emit) {
    //- B1: huỷ stream cũ
    _tickerSubscription?.cancel();

    // stop audio
    _audioBloc.add(AudioEventOnStopAudio());

    //- B2: reset 
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

  void _onStartTicked(_PromodoroTimerEventOnStartTicked event, Emitter<PromodorTimerState> emit) {
    //- B1: huỷ stream cũ nếu có
    _tickerSubscription?.cancel();

    //- B2: chạy stream mới
    _tickerSubscription = _ticker
      .tick(
        limit: Globals.timePerPoromodor * 60 - state.secondsCompleteInCurrentSection, 
        startAt: state.secondsCompleteInCurrentSection,
      )
      .listen(
        (seconds) => add(_PromodoroTimerEventOnTicked(seconds: seconds)),
        onDone: () {
          add(PromodorTimerEventOnEndSection());
        },
      ); 
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
    add(_PromodoroTimerEventOnStartTicked());
  }

  void _onRefresh(PromodorTimerEventOnRefresh event, Emitter emit) {
    emit(PromodorTimerState());
  }

  void _onSkipSection(PromodorTimerEventOnSkipSection event, Emitter emit) {
    //- B1: huỷ stream cũ
    _tickerSubscription?.cancel();

    //- B2: 
    // seconds = 0. (Nếu đặt = max => giao diện bị nháy)
    // quay về trạng thái khởi tạo
    emit(state.copyWith(
      status: PromodorTimerStatus.initial,
      secondsCompleteInCurrentSection: Globals.timePerPoromodor * 60,
    ));

    //- B3: phát sự kiện để lưu thông tin vào database
    _promodorTaskBloc.add(PromodorTaskEventOnUpdate(secondsCompleteInCurrentSection: Globals.timePerPoromodor * 60));

    //- B4: stop audio
    _audioBloc.add(AudioEventOnStopAudio());
  }

  void _onEndSection(PromodorTimerEventOnEndSection event, Emitter emit) {
    //- B1: huỷ stream cũ
    _tickerSubscription?.cancel();

    //- B2: 
    // seconds = 0. (Nếu đặt = max => giao diện bị nháy)
    // quay về trạng thái khởi tạo
    emit(state.copyWith(
      status: PromodorTimerStatus.sectionEnded,
    ));

    //- B3: phát sự kiện để lưu thông tin vào database
    _promodorTaskBloc.add(PromodorTaskEventOnUpdate(secondsCompleteInCurrentSection: state.secondsCompleteInCurrentSection));

    //- B4: stop audio
    _audioBloc.add(AudioEventOnStopAudio());

    //- B5: break time
    add(PromodorTimerEventOnBreakTime());
  }

  void _onBreakTime(PromodorTimerEventOnBreakTime event, Emitter emit) {
    //- B1: Kiểm tra mặc định có hiển thị breakTime hay không

    //- B2: thay đổi trạng thái
    emit(state.copyWith(
      status: PromodorTimerStatus.breakTime
    ));

    //- B3: chạy audio thông báo đã đến thời điểm breakTime
    _audioBloc.add(AudioEventOnPlayAudioInBreakTime());

    //- B4: bắt đầu breakTime & kết thúc breakTime => chạy đồng hồ tiếp
    _breakTimeTickerSubscription = Ticker().tick(
      limit: Globals.breakTimePerPoromodor, 
      startAt: 0
    ).listen(
      (seconds) {
        add(_PromodoroTimerEventOnBreakTimeTicked(seconds: seconds));
      },
      onDone: () => add(PromodorTimerEventOnCancleBreakTime()),
    );
  }

  void _onBreakTimeTicked(_PromodoroTimerEventOnBreakTimeTicked event, Emitter<PromodorTimerState> emit) {
    emit(state.copyWith(
      secondsInBreakTime: event.seconds
    ));
  }

  void _onCancleBreakTime(PromodorTimerEventOnCancleBreakTime event, Emitter emit) {
    //- B1: huỷ break time
    _breakTimeTickerSubscription?.cancel();

    //- B2: thay đổi trạng thái
    emit(state.copyWith(
      status: PromodorTimerStatus.endBreakTime
    ));

    //- B3: stop audio
    _audioBloc.add(AudioEventOnStopAudio());

    //- B4: chạy đồng hồ
    add(PromodorTimerEventOnStart());

  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

}
