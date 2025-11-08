import 'package:flutter/material.dart';
import 'package:focus_app/main/app.dart';
import 'package:focus_app/main/app_env.dart';
import 'package:focus_app/utils/storages/sql/database.dart';

/// func used for every environment ( dev or product )
Future<void> mainCommon (AppEnvEnum environment) async {
  // init env
  await AppEnv.init(environment);

  // init Sqflite database
  await FDatabase().init();


  runApp(MyApp());
}