import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/features/task/blocs/add_new_task/add_new_task_bloc.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class PomodoroSelector extends StatelessWidget {

  const PomodoroSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final pomodoros = context.watch<AddNewTaskBloc>().state.pomodoros;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.sm,
      children: [
        const SectionLable(title: 'Estimated Pomodoros'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(10, (index) {
              final value = index + 1;
              final isSelected = pomodoros == value;
              return Padding(
                padding: EdgeInsets.only(right: Sizes.sm),
                child: RoundedContainer(
                  onPressed: () {
                    context.read<AddNewTaskBloc>().add(AddNewTaskPomodorosChanged(value));
                  },
                  bg: isSelected ? AppColors.primary : Colors.transparent,
                  border: Border.all(color: AppColors.gray),
                  width: 30,
                  height: 30,
                  px: 0,
                  py: 0,
                  child: Center(
                    child: Text(
                      '$value',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: isSelected ? AppColors.white : AppColors.black,
                          ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}