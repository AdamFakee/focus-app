import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/cards/task_card.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/common/widgets/feedbacks/not_found_item.dart';
import 'package:focus_app/features/task/blocs/active_task/active_task_bloc.dart';
import 'package:focus_app/features/task/blocs/lazy_loading/lazy_loading_bloc.dart';
import 'package:focus_app/features/task/blocs/task_action/task_action_bloc.dart';
import 'package:focus_app/features/task/models/task_model.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/helpers/task_flag_helper.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ActiveTasksTab extends StatefulWidget {

  const ActiveTasksTab({super.key});

  @override
  State<ActiveTasksTab> createState() => _ActiveTasksTabState();
}

class _ActiveTasksTabState extends State<ActiveTasksTab> {
  /// thời điểm [CRUD] mới nhất của [Task_Table] khi [RecentlySection] được khởi tạo 
  DateTime? _currentTaskTableCreateAt;

  @override
  void initState() {
    super.initState();
 
    _loadInitialData();
  }


  Future<void> _loadInitialData() async {
    _currentTaskTableCreateAt = await TaskFlagHelper.getLastTaskChange();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTasksBloc, LazyLoadingState<TaskModel>>(
      builder: (context, state) {
        final bloc = context.read<ActiveTasksBloc>();
        return PagedListView<int, TaskModel>.separated(
          state: state, 
          fetchNextPage: () {
            bloc.add(LazyLoadingFetchNext());
          }, 
          builderDelegate: PagedChildBuilderDelegate(
            noItemsFoundIndicatorBuilder: (context) {
              return NotFoundItem();
            },
            itemBuilder:(context, task, index) {
              return TaskCard(
                isCompleted: false,
                mainIcon: task.icon,
                mainIconBackgroundColor: task.color,
                title: task.taskName,
                progressText: task.progressPomodoros,
                durationText: task.timeProgress,
                trailing: IconContainer(
                  icon: Icons.play_arrow,
                  backgroundColor: AppColors.lightGray,
                ),
                onDelete: task.taskId != null ? () {
                  context.read<TaskActionBloc>().add(TaskActionOnDelete(taskId: task.taskId!));
                } : null,
                onTap: () async {
                  await context.push<bool>(AppRouterNames.pomodoro, extra: task);
                  final shouldFetch = await TaskFlagHelper.shouldRefresh(_currentTaskTableCreateAt);
                  if ( shouldFetch && context.mounted) {
                    context.read<ActiveTasksBloc>().add(LazyLoadingRefresh());
                  } 
                },
              );
            },
          ), 
          separatorBuilder: (BuildContext context, int index) { 
            return SizedBox(
              height: Sizes.md,
            );
          },
        );
      },
    );
  }
}
