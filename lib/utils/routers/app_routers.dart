import 'package:flutter/material.dart';
import 'package:focus_app/features/home/home.dart';
import 'package:go_router/go_router.dart';


class AppRouters {
  static GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

  static final GoRouter routers = GoRouter(
    navigatorKey: rootKey,
    initialLocation: '/',
    restorationScopeId: 'router',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Home(),
      )
    ],
  ); 
}