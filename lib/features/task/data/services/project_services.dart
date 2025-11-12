import 'package:focus_app/features/task/models/project_model.dart';
import 'package:focus_app/utils/storages/sql/database.dart';
import 'package:focus_app/utils/storages/sql/tables/project/project_table.dart';

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
}