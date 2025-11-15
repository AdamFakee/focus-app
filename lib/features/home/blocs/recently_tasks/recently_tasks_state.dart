// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recently_tasks_bloc.dart';

enum SubmissionStatus { initial, loading, failure }

class RecentlyTasksState extends Equatable {
  final List<TaskModel> tasks;
  final SubmissionStatus status;
  final String? errorMessage;

  const RecentlyTasksState({
    this.tasks = const [], 
    this.status = SubmissionStatus.initial,
    this.errorMessage
  });
  
  @override
  List<Object> get props => [status, tasks];

  RecentlyTasksState copyWith({
    List<TaskModel>? tasks,
    SubmissionStatus? status,
    String? errorMessage,
  }) {
    return RecentlyTasksState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

