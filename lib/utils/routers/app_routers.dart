import 'package:flutter/material.dart';
import 'package:focus_app/utils/routers/bottom_navigations/bottom_navigation.dart';
import 'package:go_router/go_router.dart';


class AppRouters {
  static GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

  static final GoRouter routers = GoRouter(
    navigatorKey: rootKey,
    initialLocation: '/home',
    restorationScopeId: 'router',
    routes: [
      // Bottom navigation
      BottomNavigation.routers,
    ],
  ); 
}