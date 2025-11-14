import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/buttons/add_button.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/features/task/blocs/add_new_task/add_new_task_bloc.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:go_router/go_router.dart';


class TagSelector extends StatelessWidget {
  final VoidCallback onRefresh;

  const TagSelector({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final tags = context.watch<AddNewTaskBloc>().state.tags;
    final tagIds = context.watch<AddNewTaskBloc>().state.tagIds;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.sm,
      children: [
        const SectionLable(title: 'Tags'),

        //- List tags
        if(tags.isNotEmpty)
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
                      context.read<AddNewTaskBloc>().add(AddNewTaskTagsUpdated(tag.tagId!));
                    }
                  },
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.gray
                  ),
                  child: Text(
                    tag.tagName,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: isSelected ? AppColors.white : AppColors.black
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        
        //- Navigate to create-new-tag-screen
        if(tags.isEmpty)
          AddButtonCommon(
            onPressed: () async {
              // tạo mới project => refresh
              final refresh = await context.push<bool>(AppRouterNames.addNewTag);
              if(refresh == true) {
                onRefresh();
              }
            },
            title: "Create New Tag",
          )
      ],
    );
  }
}
