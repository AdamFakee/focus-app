import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/add_new_tag/add_new_tag_bloc.dart';
import 'package:focus_app/features/task/data/repos/tag_repo.dart';
import 'package:focus_app/features/task/views/screens/add_new_tag/add_new_tag_page.dart';
import 'package:focus_app/utils/popups/fullscreen_loader.dart';
import 'package:focus_app/utils/popups/snackbar.dart';

class AddNewTagScreen extends StatelessWidget {
  const AddNewTagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TagRepo(),
      child: BlocProvider(
        create: (context) => AddNewTagBloc(tagRepo: context.read<TagRepo>()),
        child: BlocListener<AddNewTagBloc, AddNewTagState>(
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
          child: AddNewTagPage(),
        ),
      ),
    );
  }
}
