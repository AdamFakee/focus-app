import 'package:flutter/material.dart';
import 'package:focus_app/features/task/views/screens/add_new_project/add_new_project_screen.dart';
import 'package:focus_app/features/task/views/screens/add_new_tag/add_new_tag_screen.dart';
import 'package:focus_app/features/task/views/screens/add_new_task/add_new_task_screen.dart';
import 'package:focus_app/features/task/views/screens/edit_tag/edit_tag_screen.dart';
import 'package:focus_app/features/task/views/screens/tags/tags_screen.dart';
import 'package:focus_app/features/task/views/screens/task/task_screen.dart';
import 'package:focus_app/utils/routers/app_routers.dart';
import 'package:go_router/go_router.dart';


class TaskTabBottomNavigation {
  static GlobalKey<NavigatorState> tabKey = GlobalKey<NavigatorState>();

  static StatefulShellBranch get branch => StatefulShellBranch(
    navigatorKey: tabKey,
    routes: [
      GoRoute(
        path: '/task', 
        builder: (context, state) => const TaskScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: AppRouters.rootKey,
            path: 'addNewTask',
            builder: (context, state) => const AddNewTaskScreen(),
          ),
          GoRoute(
            parentNavigatorKey: AppRouters.rootKey,
            path: 'addNewTag',
            builder: (context, state) => const AddNewTagScreen(),
          ),
          GoRoute(
            parentNavigatorKey: AppRouters.rootKey,
            path: 'addNewProject',
            builder: (context, state) => const AddNewProjectScreen(),
          ),
          GoRoute(
            parentNavigatorKey: AppRouters.rootKey,
            path: 'tags',
            builder: (context, state) => const TagScreen(),
            routes: [
              GoRoute(
                parentNavigatorKey: AppRouters.rootKey,
                path: 'edit/:id',
                builder: (context, state) {
                  // check tagId, nếu không tồn tại => tagId = -1
                  final tagIdString = state.pathParameters['id'];
                 final int tagId = int.tryParse(tagIdString ?? '') ?? -1;
                  return EditTagScreen(tagId: tagId);
                }
              ),
            ]
          ),
        ]
      )
    ]
  );
}