import 'package:focus_app/features/task/blocs/lazy_loading/lazy_loading_bloc.dart';
import 'package:focus_app/features/task/data/repos/task_repo.dart';
import 'package:focus_app/features/task/models/task_model.dart';
import 'package:focus_app/utils/const/global.dart';

class CompletedTaskBloc extends LazyLoadingBloc<TaskModel> {
  CompletedTaskBloc({required TaskRepo taskRepo})
      : super(
          fetchFn: (pageKey, _) {
            return taskRepo.getAll(
              page: pageKey, 
              limit: Globals.limitInPagination,
              status: TaskStatus.completed
            );
          },
        );
}

