import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/home/blocs/audio/audio_bloc.dart';
import 'package:focus_app/features/home/blocs/promodor_task/promodor_task_bloc.dart';
import 'package:focus_app/features/home/blocs/promodor_time/promodor_timer_bloc.dart';
import 'package:focus_app/features/home/blocs/promodor_time/test.dart';
import 'package:focus_app/features/home/blocs/recently_tasks/recently_tasks_bloc.dart' hide SubmissionStatus;
import 'package:focus_app/features/home/view/screens/home/home_page.dart';
import 'package:focus_app/features/home/view/widgets/home/break_time_pop_up.dart';
import 'package:focus_app/features/task/blocs/task_action/task_action_bloc.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';
import 'package:focus_app/utils/helpers/audio_helper.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';
import 'package:focus_app/utils/storages/share_preference/share_preference_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TaskRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RecentlyTasksBloc( taskRepo: context.read<TaskRepo>())..add(RecentlyTasksOnFetched())
          ),
          BlocProvider(
            create: (context) => TaskActionBloc(taskRepo: context.read<TaskRepo>()),
          ),
          BlocProvider(
            create: (context) => PromodorTaskBloc(taskRepo: context.read<TaskRepo>()),
          ),
          BlocProvider(
            create: (context) => PromodorTimerBloc(
              promodorTaskBloc: context.read<PromodorTaskBloc>(),
              ticker: Ticker()
            ),
          ),
          BlocProvider(
            create: (context) => AudioBloc(
              audio: AudioHelper(),
              storage: SharePreferenceStorage()
            )..add(AudioEventOnInitial()),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<PromodorTaskBloc, PromodorTaskState>(
              listener: (context, state) async {                
                // XỬ LÝ LỖI 
                if (state.status == PromodorTaskStatus.failue) {
                  final errorMessage = 'Something went wrong. We have to refresh screen.';
                  Snackbar.show(context, type: SnackbarEnum.error, message: errorMessage);

                  await Future.delayed(Duration(seconds: 4), () {
                    if(context.mounted) {
                      context.read<RecentlyTasksBloc>().add(RecentlyTasksOnFetched());
                      context.read<PromodorTaskBloc>().add(PromodorTaskEventOnRefresh());
                      context.read<PromodorTimerBloc>().add(PromodorTimerEventOnRefresh());
                    }
                  });
                  return;
                }
              },
            ),
            BlocListener<TaskActionBloc, TaskActionState>(
              listener: (context, state) {
                // XỨ LÝ LOADING
                if(state.status == SubmissionStatus.loading) {
                  FullscreenLoader.show(context);
                  return;
                }
                
                // XỬ LÝ LỖI KHI SUBMIT
                if (state.status == SubmissionStatus.failure) {
                  final errorMessage = state.errorMessage ?? 'Delete Task Fail.';
                  Snackbar.show(context, type: SnackbarEnum.error, message: errorMessage);
                  return;
                }
              },
            ),
            BlocListener<PromodorTimerBloc, PromodorTimerState>(
              listenWhen: (previous, current) {
                final statusChange = previous.status != current.status;

                return statusChange;
              },
              listener: (context, state) async {                
                // XỬ LÝ BREAK TIME
                if(state.status == PromodorTimerStatus.breakTime) {
                  showBreakTimePopup(context);
                }
              },
            ),
          ],
          child: HomePage(),
        ),
      ),
    );
  }
}
