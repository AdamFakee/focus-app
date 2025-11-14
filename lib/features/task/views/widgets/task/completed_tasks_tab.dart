import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/cards/task_card.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/common/widgets/feedbacks/not_found_item.dart';
import 'package:focus_app/features/task/blocs/completed_task/completed_task_bloc.dart';
import 'package:focus_app/features/task/blocs/lazy_loading/lazy_loading_bloc.dart';
import 'package:focus_app/features/task/models/task_model.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CompletedTasksTab extends StatelessWidget {
  const CompletedTasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedTaskBloc, LazyLoadingState<TaskModel>>(
      builder: (context, state) {
        final bloc = context.read<CompletedTaskBloc>();
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
                isCompleted: true,
                mainIcon: task.icon,
                mainIconBackgroundColor: task.color,
                title: task.taskName,
                progressText: task.progressPomodoros,
                durationText: task.timeProgress,
                trailing: IconContainer(
                  icon: Icons.play_arrow,
                  backgroundColor: AppColors.lightGray,
                ),
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
