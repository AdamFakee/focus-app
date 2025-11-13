// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focus_app/utils/storages/sql/tables/task/task_table.dart';

enum TaskStatus {active, completed, deleted}

class TaskModel {
  final int? taskId;
  final String taskName;
  final int totalPomodoros; // Tổng số pomodoro dự kiến
  final int completedPomodoros; // Số pomodoro đã hoàn thành
  final TaskStatus status;
  // Lưu projectId, có thể null nếu task không thuộc project nào
  final int? projectId; 
  
  // Một task có thể có nhiều tag, nên ta lưu một danh sách các tagId
  final List<int> tagIds; 

  final Color color;
  final IconData icon;
  final DateTime createdAt;
  final Duration durationSpent; // Tổng thời gian đã làm, dùng Duration cho tiện xử lý

  TaskModel({
    this.status = TaskStatus.active,
    this.taskId,
    required this.taskName,
    required this.totalPomodoros,
    required this.completedPomodoros,
    required this.icon,
    this.projectId,
    this.tagIds = const [],
    required this.color,
    required this.createdAt,
    required this.durationSpent,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final tagIdsRaw = json[TaskTable.columnTagIds];
    final List<int> tagIds = tagIdsRaw != null && tagIdsRaw is String
        ? List<int>.from(jsonDecode(tagIdsRaw))
        : [];

    final statusRaw = json[TaskTable.columnStatus];
    final status = TaskStatus.values.firstWhere(
      (e) => e.name == statusRaw,
      orElse: () => TaskStatus.active,
    );
    return TaskModel(
      taskId: json[TaskTable.columnTaskId],
      taskName: json[TaskTable.columnTaskName],
      totalPomodoros: json[TaskTable.columnTotalPomodoros],
      completedPomodoros: json[TaskTable.columnCompletedPomodoros],
      projectId: json[TaskTable.columnProjectId],
      tagIds: tagIds, 
      color: Color(json[TaskTable.columnColor]),
      icon: IconData(json[TaskTable.columnIconCodePoint]),
      createdAt: DateTime.parse(json[TaskTable.columnCreatedAt]),
      // Tạo lại Duration từ số giây đã lưu
      durationSpent: Duration(seconds: json[TaskTable.columnDurationSpentSeconds]),
      status: status
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TaskTable.columnTaskName: taskName,
      TaskTable.columnTotalPomodoros: totalPomodoros,
      TaskTable.columnCompletedPomodoros: completedPomodoros,
      TaskTable.columnProjectId: projectId,
      TaskTable.columnTagIds: jsonEncode(tagIds),
      TaskTable.columnColor: color.toARGB32(),
      TaskTable.columnIconCodePoint: icon.codePoint,
      TaskTable.columnCreatedAt: createdAt.toIso8601String(),
      TaskTable.columnStatus: status.name,
      // Lưu tổng số giây của Duration dưới dạng integer
      TaskTable.columnDurationSpentSeconds: durationSpent.inSeconds,
    };
  }

  @override
  String toString() {
    return 'TaskModel(taskId: $taskId, taskName: $taskName, totalPomodoros: $totalPomodoros, completedPomodoros: $completedPomodoros, projectId: $projectId, tagIds: $tagIds, color: $color, icon: $icon, createdAt: $createdAt, durationSpent: $durationSpent)';
  }
}
