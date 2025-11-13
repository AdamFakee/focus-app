import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/buttons/add_button.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/features/task/blocs/add_new_task/add_new_task_bloc.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:go_router/go_router.dart';


class ProjectDropdown extends StatelessWidget {
  const ProjectDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final projectId = context.watch<AddNewTaskBloc>().state.projectId;
    final projects = context.watch<AddNewTaskBloc>().state.projects;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.md,
      children: [
        const SectionLable(title: 'Project'),

        //- List projects
        if(projects.isNotEmpty)
          DropdownButtonFormField<int>(
            initialValue: projectId,
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (value) {
              if (value != null) {
                context.read<AddNewTaskBloc>().add(AddNewTaskProjectSelected(value));
              }
            },
            hint: Text(
              'Select project',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.lightGray,
              contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.md, vertical: 4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
            items: projects.map((project) {
              return DropdownMenuItem(
                value: project.projectId,
                child: Text(
                  project.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }).toList(),
          ),
        
        //- Navigate to create-new-project-screen
        if(projects.isEmpty) 
          AddButtonCommon(
            onPressed: () {
              context.push(AppRouterNames.addNewProject);
            }, 
            title: "Create New Project"
          )
      ],
    );
  }
}