import 'package:focus_app/features/task/models/task_model.dart';
import 'package:focus_app/utils/storages/sql/database.dart';
import 'package:focus_app/utils/storages/sql/tables/task/task_table.dart';

class TaskServices {
  // single ton
  static final TaskServices _instance = TaskServices._internal();
  TaskServices._internal();
  factory TaskServices() => _instance;


  final _db = AppDatabase().db;

  Future<int> createTask(TaskModel task) async {
    return await _db.insert(TaskTable.tableName, task.toJson());
  }

  Future<List<Map<String, Object?>>> getAll ({
    int page = 1,
    int limit = 99999,
    TaskStatus? status,
  }) async {
    final offset = (page - 1) * limit;

    final where = status != null ? '${TaskTable.columnStatus} = ?' : null;
    final whereArgs = status != null ? [status.name] : null;


    return await _db.query(
      TaskTable.tableName,
      where: where,
      whereArgs: whereArgs,
      limit: limit,
      offset: offset
    );
  }

  Future<int> deleteTask(int taskId) async {
    return await _db.delete(
      TaskTable.tableName,
      where: '${TaskTable.columnTaskId} = ?',
      whereArgs: [taskId],
    );
  }
}