// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:focus_app/utils/storages/sql/tables/tag/tag_table.dart';

class TagModel {
  final int? tagId;
  final String tagName;
  final Color color;
  final DateTime createdAt;

  TagModel({
    this.tagId,
    required this.tagName,
    required this.color,
    required this.createdAt,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      tagId: json[TagTable.columnTagId] as int,
      tagName: json[TagTable.columnName],
      color: Color(json[TagTable.columnColor]),
      createdAt: DateTime.parse(json[TagTable.columnCreatedAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TagTable.columnName: tagName,
      TagTable.columnColor: color.toARGB32(),
      TagTable.columnCreatedAt: createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TagModel(tagId: $tagId, tagName: $tagName, color: $color, createdAt: $createdAt)';
  }
}
