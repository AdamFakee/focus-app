import 'package:flutter/material.dart';
import 'package:focus_app/main/app.dart';
import 'package:focus_app/main/app_env.dart';
import 'package:focus_app/utils/helpers/audio_helper.dart';
import 'package:focus_app/utils/storages/share_preference/share_preference_storage.dart';
import 'package:focus_app/utils/storages/sql/database.dart';

/// func used for every environment ( dev or product )
Future<void> mainCommon (AppEnvEnum environment) async {
  // init env
  await AppEnv.init(environment);

  // init Sqflite database
  await AppDatabase().init();

  // init share preference storage
  await SharePreferenceStorage.instance.init();

  // init audio 
  await AudioHelper().init();


  runApp(MyApp());
}