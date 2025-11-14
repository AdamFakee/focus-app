import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/edit_project/edit_project_bloc.dart';
import 'package:focus_app/features/task/data/repos/project_repo.dart';
import 'package:focus_app/features/task/views/screens/edit_project/edit_project_page.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';
import 'package:go_router/go_router.dart';

class EditProjectScreen extends StatelessWidget {
  final int projectId;
  
  const EditProjectScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProjectRepo(),
      child: BlocProvider(
        create: (context) => EditProjectBloc(projectRepo: context.read<ProjectRepo>())..add(EditProjectFetched(projectId)),
        child: BlocListener<EditProjectBloc, EditProjectState>(
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
              FullscreenLoader.stop(context);

              // trở về màn hình trước đó 
              // thông báo cần refresh 
              context.pop(true);

              // hiển thị thông báo ở màn hình trước đó luôn
              Snackbar.show(context, type: SnackbarEnum.success, message: 'Project edit successfully!');
              return;
            }
          },
          child: EditProjectPage(),
        ),
      ),
    );
  }
}
