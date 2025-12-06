import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/home/blocs/recently_tasks/recently_tasks_bloc.dart' hide SubmissionStatus;
import 'package:focus_app/features/home/view/screens/home/home_page.dart';
import 'package:focus_app/features/task/blocs/task_action/task_action_bloc.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';

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
              },
            ),
          ],
          child: HomePage(),
        ),
      ),
    );
  }
}
