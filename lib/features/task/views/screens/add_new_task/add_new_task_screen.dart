import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/add_new_task/add_new_task_bloc.dart';
import 'package:focus_app/features/task/blocs/icon_picker/icon_picker_bloc.dart';
import 'package:focus_app/features/task/data/repos/project_repo.dart';
import 'package:focus_app/features/task/data/repos/tag_repo.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';
import 'package:focus_app/features/task/views/screens/add_new_task/add_new_task_page.dart';
import 'package:focus_app/utils/data/icons/font_awesome_icon_model.dart';
import 'package:focus_app/utils/data/icons/font_awesome_icons.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => TaskRepo()),
        RepositoryProvider(create: (context) => ProjectRepo()),
        RepositoryProvider(create: (context) => TagRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => IconPickerBloc(fetchFn: _fetchIcons),
          ),
          BlocProvider(
            // gọi event tải dữ liệu
            create: (context) => AddNewTaskBloc(
              taskRepo: context.read<TaskRepo>(),
              projectRepo: context.read<ProjectRepo>(),
              tagRepo: context.read<TagRepo>(),
            )..add( AddNewTaskDataFetched()),
          ),
        ],
        child: BlocListener<AddNewTaskBloc, AddNewTaskState>(
          listenWhen: (previous, current) {
            return previous.status != current.status ||
                   current.errorMessage != null && previous.errorMessage == null;
          },
          listener: (context, state) {
            // XỨ LÝ LOADING
            if(state.isLoading) {
              FullscreenLoader.show(context);
              return;
            }
            
            // XỬ LÝ LỖI KHI SUBMIT
            if (state.status == SubmissionStatus.failure) {
              final errorMessage = state.errorMessage ?? 'An unknown error occurred.';
              Snackbar.show(context, type: SnackbarEnum.error, message: errorMessage);
              return;
            }
            
            // XỬ LÝ KHI SUBMIT THÀNH CÔNG 
            if (state.status == SubmissionStatus.success) {
              Snackbar.show(context, type: SnackbarEnum.success, message: 'Task added successfully!');
              return;
            }
          },
          child: AddNewTaskPage(), 
        ),
      ),
    );
  }


  /// hàm filter icon cho việc search
  Future<List<FontAwesomeIconModel>> _fetchIcons(
    int pageKey,
    String? search,
  ) async {
    int pageSize = 30;

    final filteredIcons = fontAwesomeIcons
        .where(
          (icon) =>
              search == null ||
              icon.title.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();

    final startIndex = pageKey * pageSize;
    if (startIndex >= filteredIcons.length) return [];

    final endIndex = (startIndex + pageSize).clamp(0, filteredIcons.length);
    return filteredIcons.sublist(startIndex, endIndex);
  }
}