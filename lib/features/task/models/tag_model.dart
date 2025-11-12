import 'package:flutter/material.dart';
import 'package:focus_app/utils/storages/sql/tables/tag/tag_table.dart';

class TagModel {
  final String? tagId;
  final String name;
  final Color color;
  final DateTime createdAt;

  TagModel({
    this.tagId,
    required this.name,
    required this.color,
    required this.createdAt,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      tagId: json[TagTable.columnTagId],
      name: json[TagTable.columnName],
      color: Color(json[TagTable.columnColor]),
      createdAt: DateTime.parse(json[TagTable.columnCreatedAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TagTable.columnTagId: tagId,
      TagTable.columnName: name,
      TagTable.columnColor: color.toARGB32(),
      TagTable.columnCreatedAt: createdAt.toIso8601String(),
    };
  }
}
