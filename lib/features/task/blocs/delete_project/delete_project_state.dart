part of 'delete_project_bloc.dart';

enum SubmissionStatus { initial, loading, success, failure }

final class DeleteProjectState extends Equatable {
  final SubmissionStatus status;

  final String? errorMessage;

  const DeleteProjectState({
    this.status = SubmissionStatus.initial,
    this.errorMessage,
  });

  DeleteProjectState copyWith({
    SubmissionStatus? status,
    String? errorMessage,
  }) {
    return DeleteProjectState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}