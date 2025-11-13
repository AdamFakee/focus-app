
part of 'delete_tag_bloc.dart';

enum SubmissionStatus { initial, loading, success, failure }

final class DeleteTagState extends Equatable {
  final SubmissionStatus status;

  final String? errorMessage;

  const DeleteTagState({
    this.status = SubmissionStatus.initial,
    this.errorMessage,
  });

  DeleteTagState copyWith({
    SubmissionStatus? status,
    String? errorMessage,
  }) {
    return DeleteTagState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}