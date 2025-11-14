import 'package:flutter/material.dart';
import 'package:focus_app/features/home/view/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';

class HomeTabBottomNavigation {
  static GlobalKey<NavigatorState> tabKey = GlobalKey<NavigatorState>();

  static StatefulShellBranch get branch => StatefulShellBranch(
    navigatorKey: tabKey,
    routes: [
      GoRoute(
        path: '/home', 
        builder: (context, state) => HomeScreen(),
        routes: []
      )
    ],
  );
}
