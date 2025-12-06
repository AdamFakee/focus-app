import 'package:flutter/material.dart';
import 'package:focus_app/features/pomodoro/views/screens/pomodoro/pomodoro_screen.dart';
import 'package:focus_app/features/task/models/task_model.dart';
import 'package:go_router/go_router.dart';


class OtherRouters {
  static GlobalKey<NavigatorState> routerKey = GlobalKey<NavigatorState>();

  static final List<GoRoute> routers = [
    GoRoute(
      path: '/pomodoro',
      builder: (context, state) {
        final task = state.extra as TaskModel;
        return PomodoroScreen(task: task,);
      },
    ),
  ];
}