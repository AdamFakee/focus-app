import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/add_new_project/add_new_project_bloc.dart';
import 'package:focus_app/features/task/data/repos/project_repo.dart';
import 'package:focus_app/features/task/views/screens/add_new_project/add_new_project_page.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';

class AddNewProjectScreen extends StatelessWidget {
  const AddNewProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProjectRepo(),
      child: BlocProvider(
        create: (context) => AddNewProjectBloc(projectRepo: context.read<ProjectRepo>()),
        child: BlocListener<AddNewProjectBloc, AddNewProjectState>(
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
          child: AddNewProjectPage(),
        ),
      ),
    );
  }
}
