import 'package:flutter/material.dart';
import 'package:focus_app/utils/storages/sql/tables/project/project_table.dart';

class ProjectModel {
  final String? projectId;
  final String name;
  final Color color;
  final DateTime createdAt;

  ProjectModel({
    this.projectId,
    required this.name,
    required this.color,
    required this.createdAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json[ProjectTable.columnProjectId],
      name: json[ProjectTable.columnName],
      color: Color(json[ProjectTable.columnColor]),
      createdAt: DateTime.parse(json[ProjectTable.columnCreatedAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ProjectTable.columnProjectId: projectId,
      ProjectTable.columnName: name,
      ProjectTable.columnColor: color.toARGB32(),
      ProjectTable.columnCreatedAt: createdAt.toIso8601String(),
    };
  }
}
