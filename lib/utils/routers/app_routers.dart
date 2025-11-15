import 'package:flutter/material.dart';
import 'package:focus_app/utils/routers/app_router_obsever.dart';
import 'package:focus_app/utils/routers/bottom_navigations/bottom_navigation.dart';
import 'package:go_router/go_router.dart';


class AppRouters {
  static GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

  static final GoRouter routers = GoRouter(
    observers: [AppRouterObsever.instance,],
    navigatorKey: rootKey,
    initialLocation: '/home',
    restorationScopeId: 'router',
    routes: [
      // Bottom navigation
      BottomNavigation.routers,
    ],
  ); 
}