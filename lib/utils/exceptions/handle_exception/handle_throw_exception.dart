// ignore_for_file: non_constant_identifier_names

import 'package:focus_app/utils/exceptions/sqflite/sqflite_database_exeption.dart';
import 'package:sqflite/sqflite.dart';

/// wrap [action] to handle throw [exception] if exist
/// 
/// using when call api to firebase
Future<T> HandleThrowException<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on DatabaseException catch (e) {
    print(e);
    throw SqfliteDatabaseExeption.error(e).message;
  } catch (e) {
    print(e);
    rethrow;
  }
}
