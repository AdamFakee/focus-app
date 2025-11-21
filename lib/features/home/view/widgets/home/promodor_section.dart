import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/cards/task_card.dart';
import 'package:focus_app/features/home/blocs/promodor_task/promodor_task_bloc.dart';
import 'package:focus_app/features/home/view/widgets/home/pomodor_clock.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/popups/confirm_popup.dart';

class PromodorSection extends StatelessWidget {
  const PromodorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PromodorTaskBloc, PromodorTaskState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {

        /// xác nhận thay đổi task trong pomodoror
        if(state.status == PromodorTaskStatus.askConfirmChangeTask) {
          ConfirmPopup.show(context: context).then((confirm) {
            if(confirm && context.mounted) {
              context.read<PromodorTaskBloc>().add(PromodorTaskEventOnConfirmChangeTask());
            } else {
              context.read<PromodorTaskBloc>().add(PromodorTaskEventOnCancleChangeTask());
            }
          });
        }
      },
      builder: (context, state) {
        final task = state.selectedTask;
        return Column(
          spacing: Sizes.md,
          children: [
            TaskCard(
              mainIcon: task?.icon ?? Icons.refresh,
              mainIconBackgroundColor: task?.color ?? AppColors.primary,
              title: task?.taskName ?? "Create a new task",
              progressText: task?.progressPomodoros ?? "--/--",
              durationText: task?.timeProgress ?? "--/-- mins",
              trailing: Icon(Icons.expand_more, color: Colors.grey.shade600),
              onTap: () {},
            ),

            PomodorClock(),
          ],
        );
      },
    );
  }
}
