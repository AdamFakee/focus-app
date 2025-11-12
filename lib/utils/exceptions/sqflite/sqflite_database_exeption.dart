import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseExeption implements Exception{
  final String _message;

  String get message => _message;

  factory SqfliteDatabaseExeption.error(DatabaseException error) {
    String message = "Unknown database error";

    if (error.isNoSuchTableError()) {
      message = "Table does not exist";
    } else if (error.isDuplicateColumnError()) {
      message = "Duplicate column error";
    } else if (error.isNotNullConstraintError()) {
      message = "NOT NULL constraint failed";
    } else if (error.isUniqueConstraintError()) {
      message = "Unique constraint failed";
    } else if (error.isDatabaseClosedError()) {
      message = "Database is closed";
    } else if (error.isReadOnlyError()) {
      message = "Database is read-only";
    } else if (error.isSyntaxError()) {
      message = "SQL syntax error";
    } else if (error.isOpenFailedError()) {
      message = "Failed to open database";
    }

    return SqfliteDatabaseExeption(message);
  }


  const SqfliteDatabaseExeption([this._message = 'Have an error in database']);}