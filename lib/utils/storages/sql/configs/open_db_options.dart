import 'dart:async';

import 'package:focus_app/utils/storages/sql/configs/db_migration.dart';
import 'package:sqflite/sqflite.dart';

class OpenDbOptions {
  static final int _nbMigration = DbMigration.length;
  
  static FutureOr<void> onConfigure (Database db) async {
    // enable foreign key
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static FutureOr<void> onCreate (Database db, int currentVersion) async {
    await db.transaction((txn) async {
      for (int i = 1; i <= _nbMigration; i++) {
        await txn.execute(DbMigration[i]!);
      }
    });
  }

  static FutureOr<void> onUpgrade (Database db, int oldVersion, int newVersion) async {
    await db.transaction((txn) async {
      for (int i = oldVersion + 1; i <= newVersion; i++) {
        await db.execute(DbMigration[i]!);
      }
    });
  }

  static FutureOr<void> onDownGrade (Database db, int oldVersion, int newVersion) async {

  }
}