import 'package:flutter/material.dart';
import 'package:focus_app/features/task/models/project_model.dart';
import 'package:focus_app/features/task/models/tag_model.dart';
import 'package:focus_app/features/task/models/task_model.dart';

class TaskViewModel {
  final TaskModel task;

  final ProjectModel? project;

  final List<TagModel> tags;

  TaskViewModel({
    required this.task,
    this.project,
    this.tags = const [],
  });

  String get taskName => task.taskName;
  Color get color => task.color;
  String? get projectName => project?.name;
  Color? get projectColor => project?.color;
}