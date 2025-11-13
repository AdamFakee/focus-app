import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:go_router/go_router.dart';

// Menu
enum TaskMenuAction {
  manageProjects(
    title: 'Manage Projects',
    icon: Icons.business_center_outlined,
  ),
  manageTags(
    title: 'Manage Tags',
    icon: Icons.label_outline,
  );

  final String title;
  final IconData icon;

  const TaskMenuAction({
    required this.title,
    required this.icon,
  });

  void execute(BuildContext context) {
    switch (this) {
      case TaskMenuAction.manageProjects:
        break;
      case TaskMenuAction.manageTags:
        context.push(AppRouterNames.tags);
        break;
    }
  }
}

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: 'Tasks',
      showBackButton: false,
      actions: [
        PopupMenuButton<TaskMenuAction>(
          // chỉnh position theo kToolbarHeight
          offset: Offset(0, kToolbarHeight * 0.8),
          color: AppColors.white,
          icon: const Icon(Icons.more_vert, color: AppColors.black,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.sm),
          ),
          onSelected: (action) => action.execute(context),
          itemBuilder: (context) {
            return TaskMenuAction.values.map((action) {
              return PopupMenuItem<TaskMenuAction>(
                value: action,
                padding: const EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.md / 2),
                child: Row(
                  children: [
                    Icon(action.icon, color: AppColors.black),
                    const SizedBox(width: Sizes.spaceBtwItems),
                    Text(action.title),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}