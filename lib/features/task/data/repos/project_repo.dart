import 'package:focus_app/features/task/data/services/project_services.dart';
import 'package:focus_app/features/task/models/project_model.dart';
import 'package:focus_app/utils/exceptions/handle_exception/handle_throw_exception.dart';

class ProjectRepo {
  // single ton
  static final ProjectRepo _instance = ProjectRepo._internal();
  ProjectRepo._internal();
  factory ProjectRepo() => _instance;

  // variables
  final _projectServices = ProjectServices();

  Future<bool> createProject (ProjectModel project) async {
    return await HandleThrowException<bool>(() async {
      final res = await _projectServices.createProject(project);
      return res > 0 ? true : false;
    });
  }

  Future<List<ProjectModel>> getAll({
    int page = 1,
    int limit = 99999
  }) async {
    return await HandleThrowException(() async {
      final projects = await _projectServices.getAll(page: page, limit: limit);

      return projects.map((a) => ProjectModel.fromJson(a)).toList();
    });
  }
}