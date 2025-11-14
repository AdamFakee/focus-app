part of 'edit_project_bloc.dart';

enum SubmissionStatus { initial, loading, success, failure }

@immutable
class EditProjectState extends Equatable {
  final bool isLoading;
  final SubmissionStatus status;
  final int? projectId;
  final String? projectName;
  final Color? color;
  final String? errorMessage;

  const EditProjectState({
    this.isLoading = false,
    this.status = SubmissionStatus.initial,
    this.projectId,
    this.projectName,
    this.color,
    this.errorMessage,
  });

  EditProjectState copyWith({
    bool? isLoading,
    SubmissionStatus? status,
    int? projectId,
    String? projectName,
    Color? color,
    String? errorMessage,
  }) {
    return EditProjectState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      color: color ?? this.color,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        status,
        projectId,
        projectName,
        color,
        errorMessage,
      ];
}
