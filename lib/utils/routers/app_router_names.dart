// a class contain route name for entire screens in app
class AppRouterNames {
  // --------- home -----------
  static const homeTab = '/home';

  // --------- task -----------
  static const taskTab = '/task';
  static const addNewTask = '$taskTab/addNewTask';
  static const addNewTag = '$taskTab/addNewTag';
  static const addNewProject = '$taskTab/addNewProject';
  static const tags = '$taskTab/tags';
  static String editTag(int tagId) {
    return '$tags/edit/$tagId';
  }
}