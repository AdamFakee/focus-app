part of 'add_new_task_bloc.dart';

// Enum để quản lý trạng thái của hành động submit
enum SubmissionStatus { initial, loading, success, failure }

extension AddNewTaskStateEx on SubmissionStatus {
  bool get isLoadingOrSuccess => [
    SubmissionStatus.loading,
    SubmissionStatus.success,
  ].contains(this);
}

@immutable
class AddNewTaskState extends Equatable {
  final bool isLoading;
  final SubmissionStatus status;
  
  // Dữ liệu cho form
  final String taskName;
  final IconData? icon;
  final int pomodoros;
  final String? projectId;
  final List<String> tagIds;
  final Color? color;

  // Nguồn dữ liệu để hiển thị trong UI 
  final List<ProjectModel> projects;
  final List<TagModel> tags;

  // error
  final String? errorMessage;
  
  const AddNewTaskState({
    this.isLoading = true, 
    this.status = SubmissionStatus.initial,
    this.taskName = '',
    this.icon,
    this.pomodoros = 1,
    this.projectId,
    this.tagIds = const [],
    this.color,
    this.projects = const [],
    this.tags = const [],
    this.errorMessage
  });

  AddNewTaskState copyWith({
    bool? isLoading,
    SubmissionStatus? status,
    String? taskName,
    IconData? icon,
    int? pomodoros,
    String? projectId,
    List<String>? tagIds,
    Color? color,
    List<ProjectModel>? projects,
    List<TagModel>? tags,
    String? errorMessage
  }) {
    return AddNewTaskState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      taskName: taskName ?? this.taskName,
      icon: icon ?? this.icon,
      pomodoros: pomodoros ?? this.pomodoros,
      projectId: projectId ?? this.projectId,
      tagIds: tagIds ?? this.tagIds,
      color: color ?? this.color,
      projects: projects ?? this.projects,
      tags: tags ?? this.tags,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
  
  @override
  List<Object?> get props => [isLoading, status, taskName, icon, pomodoros, projectId, tagIds, color, tags, projects, errorMessage];
}