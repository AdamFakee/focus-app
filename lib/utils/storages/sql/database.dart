import 'dart:io';
import 'package:focus_app/main/app_env.dart';
import 'package:focus_app/utils/const/global.dart';
import 'package:focus_app/utils/storages/sql/configs/open_db_options.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FDatabase {
  // signle instance
  static final FDatabase _instance = FDatabase._internal();

  FDatabase._internal();

  factory FDatabase() => _instance;

  // variables
  late final Database _db;

  Database get db => _db;

  Future<void> init() async {
    _db = await _onpenDb();
  }

  Future<Database> _onpenDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, Globals.dbName);

    // nếu dbPath chưa tồn tại => tạo mới
    try {
      await Directory(dbPath).create(recursive: true);
    } catch (_) {
      throw ('Có lỗi khi khởi tạo database');
    }

    return await openDatabase(
      version: int.parse(AppEnv.databaseVersion),
      path,
      onConfigure: OpenDbOptions.onConfigure,
      onCreate: OpenDbOptions.onCreate,
      onUpgrade: OpenDbOptions.onUpgrade,
      onDowngrade: OpenDbOptions.onDownGrade,
    );
  }

  Future<void> closeDb () async {
    await _db.close();
  }
}
