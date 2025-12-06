import 'package:flutter_background_service/flutter_background_service.dart';

abstract class BackgroundTaskInterface {
  /// hàm init chạy đầu tiên
  /// 
  /// `Mặc định`: rỗng
  void init() {}

  void onStart(ServiceInstance service);
}