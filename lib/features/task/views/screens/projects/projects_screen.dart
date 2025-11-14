import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/delete_project/delete_project_bloc.dart';
import 'package:focus_app/features/task/blocs/lazy_loading/lazy_loading_bloc.dart';
import 'package:focus_app/features/task/data/repos/project_repo.dart';
import 'package:focus_app/features/task/models/project_model.dart';
import 'package:focus_app/features/task/views/screens/projects/projects_page.dart';
import 'package:focus_app/utils/const/global.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProjectRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LazyLoadingBloc<ProjectModel>(
              fetchFn: (int pageKey, String? search) {
                final projectRepo = context.read<ProjectRepo>();
                return _getAllProjects(repo: projectRepo, currentPage: pageKey);
              },
            ),
          ),
          BlocProvider(
            create: (context) => DeleteProjectBloc(projectRepo: context.read<ProjectRepo>()),
          ),
        ],
        child: BlocListener<DeleteProjectBloc, DeleteProjectState>(
          listener: (context, state) {
            // XỨ LÝ LOADING
            if(state.status == SubmissionStatus.loading) {
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
              Snackbar.show(context, type: SnackbarEnum.success, message: 'Project delete successfully!');
              return;
            }
          },
          child: ProjectPage(),
        ),
      ),
    );
  }

  Future<List<ProjectModel>> _getAllProjects({
    required ProjectRepo repo,
    required int currentPage,
  }) async {
    return repo.getAll(page: currentPage, limit: Globals.limitInPagination);
  }
}
