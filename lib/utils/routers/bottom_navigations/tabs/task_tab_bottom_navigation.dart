import 'package:flutter/material.dart';
import 'package:focus_app/features/task/views/screens/add_new_tag/add_new_tag_screen.dart';
import 'package:focus_app/features/task/views/screens/add_new_task/add_new_task_screen.dart';
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
          )
        ]
      )
    ]
  );
}