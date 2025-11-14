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

  Future<ProjectModel> getProjectById (int projectId) async {
    return await HandleThrowException<ProjectModel>(() async {
      final res = await _projectServices.getProjectById(projectId);
      return ProjectModel.fromJson(res);
    });
  }

  Future<void> updateProject(ProjectModel project) async {
    return await HandleThrowException<void>(() async {
      if (project.projectId == null) {
        throw Exception('Cannot update Project without ID');
      }

      final res = await _projectServices.updateProject(project);
      
      if(res == 0) {
        throw Exception("Update Project faile");
      }
    });
  }

  Future<void> deleteProject(int projectId) async {
    return await HandleThrowException<void>(() async {
      final res = await _projectServices.deleteProject(projectId);
      
      if(res == 0) {
        throw Exception("Delete Project faile");
      }
    });
  }
}