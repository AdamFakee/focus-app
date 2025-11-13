part of 'add_new_project_bloc.dart';

enum SubmissionStatus { initial, loading, success, failure }

@immutable
class AddNewProjectState extends Equatable {
  final bool isLoading;
  final SubmissionStatus status;
  final String? projectName;
  final Color? color;
  final String? errorMessage;

  const AddNewProjectState({
    this.isLoading = false,
    this.status = SubmissionStatus.initial,
    this.projectName,
    this.color,
    this.errorMessage,
  });

  AddNewProjectState copyWith({
    bool? isLoading,
    SubmissionStatus? status,
    String? projectName,
    Color? color,
    String? errorMessage,
  }) {
    return AddNewProjectState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      projectName: projectName ?? this.projectName,
      color: color ?? this.color,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, status, projectName, color, errorMessage];
}
