// ignore_for_file: non_constant_identifier_names

/// save `SQL_CMD` for specific `database version`
/// ```dart
/// Map<int, String> migrationScripts = {
///    1: '''CREATE TABLE users (
///      id INTEGER PRIMARY KEY,
///      first_name TEXT
///  )'''
/// };
/// ```
// final Map<int, String> SDbMigration = {
//   1: '''
//     ${SUserTable.createTableQuery}
//     ${SActivityTable.createTableQuery}
//     ${SActivityTable.createForeignKeyIndex}
//   '''
// };
final Map<int, String> DbMigration = {
  
};