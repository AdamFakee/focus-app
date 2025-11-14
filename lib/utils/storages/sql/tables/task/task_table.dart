import 'package:focus_app/utils/storages/sql/tables/project/project_table.dart';

class TaskTable {
  static const String tableName = 'Tasks';

  // Columns
  static const String columnTaskId = 'taskId';
  static const String columnTaskName = 'taskName';
  static const String columnTotalPomodoros = 'totalPomodoros';
  static const String columnCompletedPomodoros = 'completedPomodoros';
  static const String columnColor = 'color';
  static const String columnIconCodePoint = 'iconCodePoint';
  static const String columnCreatedAt = 'createdAt';
  static const String columnDurationSpentSeconds = 'durationSpentSeconds';
  static const String columnStatus = 'status';
  
  // Foreign Key Column
  static const String columnProjectId = 'projectId';
  static const String columnTagIds = 'tagIds';

  static const String createTableQuery = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $columnTaskId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTaskName TEXT NOT NULL,
      $columnTotalPomodoros INTEGER NOT NULL,
      $columnCompletedPomodoros INTEGER NOT NULL,
      $columnColor INTEGER NOT NULL,
      $columnIconCodePoint INTEGER NOT NULL,
      $columnCreatedAt TEXT NOT NULL,
      $columnStatus TEXT NOT NULL,
      $columnTagIds TEXT,
      $columnDurationSpentSeconds INTEGER NOT NULL,
      $columnProjectId INTEGER,
      FOREIGN KEY($columnProjectId) 
        REFERENCES ${ProjectTable.tableName}(${ProjectTable.columnProjectId}) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE
    );
  ''';
  
  static const String createForeignKeyIndex = '''
    CREATE INDEX IF NOT EXISTS idx_${tableName}_$columnProjectId 
    ON $tableName($columnProjectId);
  ''';
}