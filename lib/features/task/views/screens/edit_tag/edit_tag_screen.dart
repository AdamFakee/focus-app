import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/edit_tag/edit_tag_bloc.dart';
import 'package:focus_app/features/task/data/repos/tag_repo.dart';
import 'package:focus_app/features/task/views/screens/edit_tag/edit_tag_page.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';
import 'package:go_router/go_router.dart';

class EditTagScreen extends StatelessWidget {
  final int tagId;
  
  const EditTagScreen({super.key, required this.tagId});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TagRepo(),
      child: BlocProvider(
        create: (context) => EditTagBloc(tagRepo: context.read<TagRepo>())..add(EditTagFetched(tagId)),
        child: BlocListener<EditTagBloc, EditTagState>(
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
              Snackbar.show(context, type: SnackbarEnum.success, message: 'Tag edit successfully!');
              return;
            }
          },
          child: EditTagPage(),
        ),
      ),
    );
  }
}
