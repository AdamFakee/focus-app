import 'package:flutter_dotenv/flutter_dotenv.dart';


// ignore: constant_identifier_names
enum AppEnvEnum { DEV, PRODUCT }

class AppEnv {
  static AppEnvEnum _environment = AppEnvEnum.DEV;
  static Future<void> init(AppEnvEnum env) async {
    _environment = env;
    switch (_environment) {
      case AppEnvEnum.DEV: 
        await dotenv.load(fileName: "lib/envs/.env.dev");
        break;
      case AppEnvEnum.PRODUCT:
        await dotenv.load(fileName: "lib/envs/.env.product");
        break;
    }
  }

  static String get databaseVersion => dotenv.env['DATABASE_VERSION']!;

}