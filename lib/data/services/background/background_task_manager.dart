import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:focus_app/data/services/background/background_task_interface.dart';

/// Quản lý các task chạy background
class BackgroundTaskManager {
  //- Gồm các tasks được đăng ký
  final List<BackgroundTaskInterface> _tasks = [];

  /// đăng ký task 
  void register(BackgroundTaskInterface task) => _tasks.add(task);

  /// chạy task cụ thể bằng taskName
  void startAll(ServiceInstance service) {
    print("TaskManager: Starting ${ _tasks.length} tasks"); // Log để kiểm tra
    for(var task in _tasks) {
      task.onStart(service);
    }
  }
}