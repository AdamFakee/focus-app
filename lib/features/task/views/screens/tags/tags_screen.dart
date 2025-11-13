import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/delete_tag/delete_tag_bloc.dart';
import 'package:focus_app/features/task/blocs/lazy_loading/lazy_loading_bloc.dart';
import 'package:focus_app/features/task/data/repos/tag_repo.dart';
import 'package:focus_app/features/task/models/tag_model.dart';
import 'package:focus_app/features/task/views/screens/tags/tags_page.dart';
import 'package:focus_app/utils/const/global.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';

class TagScreen extends StatelessWidget {
  const TagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TagRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LazyLoadingBloc<TagModel>(
              fetchFn: (int pageKey, String? search) {
                final tagRepo = context.read<TagRepo>();
                return _getAllTags(repo: tagRepo, currentPage: pageKey);
              },
            ),
          ),
          BlocProvider(
            create: (context) =>
                DeleteTagBloc(tagRepo: context.read<TagRepo>()),
          ),
        ],
        child: BlocListener<DeleteTagBloc, DeleteTagState>(
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
              Snackbar.show(context, type: SnackbarEnum.success, message: 'Tag delete successfully!');
              return;
            }
          },
          child: TagPage(),
        ),
      ),
    );
  }

  Future<List<TagModel>> _getAllTags({
    required TagRepo repo,
    required int currentPage,
  }) async {
    return repo.getAll(page: currentPage, limit: Globals.limitInPagination);
  }
}
