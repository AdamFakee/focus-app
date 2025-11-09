import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class TaskTabBottomNavigation {
  static GlobalKey<NavigatorState> tabKey = GlobalKey<NavigatorState>();

  static StatefulShellBranch get branch => StatefulShellBranch(
    navigatorKey: tabKey,
    routes: [
      GoRoute(path: '/task', builder: (context, state) => const SizedBox(),)
    ]
  );
}