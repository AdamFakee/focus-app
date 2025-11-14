part of 'task_action_bloc.dart';

enum SubmissionStatus { initial, loading, success, failure }

final class TaskActionState extends Equatable {
  const TaskActionState({
    this.status = SubmissionStatus.initial, 
    this.errorMessage
  });
  final SubmissionStatus status;
  final String? errorMessage;

  TaskActionState copyWith({
    SubmissionStatus? status,
    String? errorMessage
  }) {
    return TaskActionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
  
  @override
  List<Object> get props => [status];
}
