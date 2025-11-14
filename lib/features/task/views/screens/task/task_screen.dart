import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/active_task/active_task_bloc.dart';
import 'package:focus_app/features/task/blocs/completed_task/completed_task_bloc.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';
import 'package:focus_app/features/task/views/screens/task/task_page.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TaskRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ActiveTasksBloc(
            taskRepo: context.read<TaskRepo>()
          )),
          BlocProvider(create: (context) => CompletedTaskBloc(
            taskRepo: context.read<TaskRepo>()
          )),
        ],
        child: TaskPage(),
      ),
    );
  }
}
