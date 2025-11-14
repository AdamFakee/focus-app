// a class contain route name for entire screens in app
class AppRouterNames {
  // --------- home -----------
  static const homeTab = '/home';

  // --------- task -----------
  static const taskTab = '/task';
  static const addNewTask = '$taskTab/addNewTask';


  // --------- Tags -----------
  static const tags = '$taskTab/tags';
  static const addNewTag = '$tags/addNewTag';
  static String editTag(int tagId) {
    return '$tags/edit/$tagId';
  }

  // ----------- Project ----------
  static const projects = '$taskTab/projects';
  static const addNewProject = '$projects/addNewProject';
  static String editProject(int projectId) {
    return '$projects/edit/$projectId';
  }
}