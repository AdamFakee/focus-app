import 'package:flutter/material.dart';
import 'package:focus_app/utils/routers/bottom_navigations/tabs/home_tab_bottom_navigation.dart';
import 'package:focus_app/utils/routers/bottom_navigations/tabs/task_tab_bottom_navigation.dart';
import 'package:focus_app/utils/routers/widgets/bottom_navigation_widget.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation {
  static GlobalKey<NavigatorState> bottomKey = GlobalKey<NavigatorState>();

  static StatefulShellRoute routers = StatefulShellRoute.indexedStack(
    builder:(context, state, navigationShell) {
      return BottomNavigationWidget(navigationShell: navigationShell);
    },
    branches: [
      HomeTabBottomNavigation.branch,
      TaskTabBottomNavigation.branch,
    ]
  );
}