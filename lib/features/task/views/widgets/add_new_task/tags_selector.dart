import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/features/task/blocs/add_new_task/add_new_task_bloc.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';


class TagSelector extends StatelessWidget {

  const TagSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final tags = context.watch<AddNewTaskBloc>().state.tags;
    final tagIds = context.watch<AddNewTaskBloc>().state.tagIds;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.sm,
      children: [
        const SectionLable(title: 'Tags'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: Sizes.sm,
            mainAxisSize: MainAxisSize.min,
            children: tags.map((tag) {
              final isSelected = tagIds.contains(tag.tagId);
              return RoundedContainer(
                radius: Sizes.lg,
                bg: isSelected ? AppColors.primary : Colors.transparent,
                onPressed: () {
                  if(tag.tagId != null) {
                    context.read<AddNewTaskBloc>().add(AddNewTaskProjectSelected(tag.tagId));
                  }
                },
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.gray
                ),
                child: Text(tag.name),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
