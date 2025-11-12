class TagTable {
  static const String tableName = 'Tags';

  // Columns
  static const String columnTagId = 'tagId';
  static const String columnName = 'name';
  static const String columnColor = 'color';
  static const String columnCreatedAt = 'createdAt';

  static const String createTableQuery = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $columnTagId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnColor INTEGER NOT NULL,
      $columnCreatedAt TEXT NOT NULL
    );
  ''';
}