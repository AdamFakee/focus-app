class ProjectTable {
  static const String tableName = 'Projects';

  // Columns
  static const String columnProjectId = 'projectId';
  static const String columnName = 'name';
  static const String columnColor = 'color';
  static const String columnCreatedAt = 'createdAt';

  static const String createTableQuery = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $columnProjectId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnColor INTEGER NOT NULL,
      $columnCreatedAt TEXT NOT NULL
    );
  ''';
}