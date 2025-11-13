import 'package:focus_app/features/task/models/tag_model.dart';
import 'package:focus_app/utils/storages/sql/database.dart';
import 'package:focus_app/utils/storages/sql/tables/tag/tag_table.dart';
import 'package:sqflite/sqflite.dart';

class TagServices {
  // single ton
  static final TagServices _instance = TagServices._internal();
  TagServices._internal();
  factory TagServices() => _instance;


  final _db = AppDatabase().db;

  Future<int> createTag(TagModel tag) async {
    return await _db.insert(TagTable.tableName, tag.toJson());
  }

  Future<List<Map<String, Object?>>> getAll ({
    int page = 1,
    int limit = 99999
  }) async {
    final offset = (page - 1) * limit;

    return await _db.query(
      TagTable.tableName,
      limit: limit,
      offset: offset
    );
  }

  Future<Map<String, Object?>> getTagById(int tagId) async {
    final result = await _db.query(
      TagTable.tableName,
      where: '${TagTable.columnTagId} = ?',
      whereArgs: [tagId],
    );

    if (result.isEmpty) {
      throw Exception('Tag with ID $tagId not found');
    }

    return result[0];
  }

  Future<int> deleteTag(int tagId) async {
    return await _db.delete(
      TagTable.tableName,
      where: '${TagTable.columnTagId} = ?',
      whereArgs: [tagId],
    );
  }

  Future<int> updateTag(TagModel tag) async {
    return await _db.update(
      TagTable.tableName,
      tag.toJson(),
      where: '${TagTable.columnTagId} = ?',
      whereArgs: [tag.tagId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}