import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/active_task/active_task_bloc.dart';
import 'package:focus_app/features/task/blocs/completed_task/completed_task_bloc.dart';
import 'package:focus_app/features/task/blocs/lazy_loading/lazy_loading_bloc.dart';
import 'package:focus_app/features/task/blocs/task_action/task_action_bloc.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';
import 'package:focus_app/features/task/views/screens/task/task_page.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TaskRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ActiveTasksBloc(taskRepo: context.read<TaskRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                CompletedTaskBloc(taskRepo: context.read<TaskRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                TaskActionBloc(taskRepo: context.read<TaskRepo>()),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
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
                
                // XỬ LÝ KHI SUBMIT THÀNH CÔNG 
                if (state.status == SubmissionStatus.success) {

                  // refresh
                  context.read<ActiveTasksBloc>().add(LazyLoadingRefresh());

                  // reset action state
                  context.read<TaskActionBloc>().add(TaskActionOnReset());

                  Snackbar.show(context, type: SnackbarEnum.success, message: 'Delete task successfully!');
                  return;
                }
              },
            ),
          ],
          child: TaskPage(),
        ),
      ),
    );
  }
}
