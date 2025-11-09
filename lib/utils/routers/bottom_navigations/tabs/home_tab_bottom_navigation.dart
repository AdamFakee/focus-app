import 'package:flutter/material.dart';
import 'package:focus_app/features/home/home.dart';
import 'package:go_router/go_router.dart';

class HomeTabBottomNavigation {
  static GlobalKey<NavigatorState> tabKey = GlobalKey<NavigatorState>();

  static StatefulShellBranch get branch => StatefulShellBranch(
    navigatorKey: tabKey,
    routes: [
      GoRoute(
        path: '/home', 
        builder: (context, state) => Home(),
        routes: []
      )
    ],
  );
}
