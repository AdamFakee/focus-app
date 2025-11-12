// ignore_for_file: non_constant_identifier_names

import 'package:focus_app/utils/storages/sql/tables/project/project_table.dart';
import 'package:focus_app/utils/storages/sql/tables/tag/tag_table.dart';
import 'package:focus_app/utils/storages/sql/tables/task/task_table.dart';

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
  1: TagTable.createTableQuery,
  2: ProjectTable.createTableQuery,
  3: TaskTable.createTableQuery,
  4: TaskTable.createForeignKeyIndex
};