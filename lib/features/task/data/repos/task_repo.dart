import 'package:focus_app/features/task/data/services/task_services.dart';
import 'package:focus_app/features/task/models/task_model.dart';
import 'package:focus_app/utils/exceptions/handle_exception/handle_throw_exception.dart';

class TaskRepo {
  // single ton
  static final TaskRepo _instance = TaskRepo._internal();
  TaskRepo._internal();
  factory TaskRepo() => _instance;

  // variables
  final _taskServices = TaskServices();

  Future<bool> createTask (TaskModel task) async {
    return await HandleThrowException<bool>(() async {
      final res = await _taskServices.createTask(task);
      return res > 0 ? true : false;
    });
  }

  Future<List<TaskModel>> getAll({
    int page = 1,
    int limit = 99999,
    TaskStatus? status
  }) async {
    return await HandleThrowException(() async {
      final task = await _taskServices.getAll(page: page, limit: limit, status: status);

      return task.map((a) => TaskModel.fromJson(a)).toList();
    });
  }
}