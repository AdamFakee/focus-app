// entry point for product environment
import 'package:focus_app/main/app_env.dart';
import 'package:focus_app/main/main_common.dart';

Future main () async => await mainCommon(AppEnvEnum.PRODUCT);
