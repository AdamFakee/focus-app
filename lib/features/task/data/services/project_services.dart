import 'package:focus_app/features/task/models/project_model.dart';
import 'package:focus_app/utils/storages/sql/database.dart';
import 'package:focus_app/utils/storages/sql/tables/project/project_table.dart';
import 'package:sqflite/sqflite.dart';

class ProjectServices {
  // single ton
  static final ProjectServices _instance = ProjectServices._internal();
  ProjectServices._internal();
  factory ProjectServices() => _instance;


  final _db = AppDatabase().db;

  Future<int> createProject(ProjectModel project) async {
    return await _db.insert(ProjectTable.tableName, project.toJson());
  }

  Future<List<Map<String, Object?>>> getAll ({
    int page = 1,
    int limit = 99999
  }) async {
    final offset = (page - 1) * limit;

    return await _db.query(
      ProjectTable.tableName,
      limit: limit,
      offset: offset
    );
  }

  Future<Map<String, Object?>> getProjectById(int projectId) async {
    final result = await _db.query(
      ProjectTable.tableName,
      where: '${ProjectTable.columnProjectId} = ?',
      whereArgs: [projectId],
    );

    if (result.isEmpty) {
      throw Exception('Project with ID $projectId not found');
    }

    return result[0];
  }

  Future<int> deleteProject(int projectId) async {
    return await _db.delete(
      ProjectTable.tableName,
      where: '${ProjectTable.columnProjectId} = ?',
      whereArgs: [projectId],
    );
  }

  Future<int> updateProject(ProjectModel project) async {
    return await _db.update(
      ProjectTable.tableName,
      project.toJson(),
      where: '${ProjectTable.columnProjectId} = ?',
      whereArgs: [project.projectId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}