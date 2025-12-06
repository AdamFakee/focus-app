part of 'promodor_task_bloc.dart';

enum PromodorTaskStatus {
  initial, 
  
  /// xác nhận chọn task mới thay thế, khi task hiện tại đang chạy hay không
  askConfirmChangeTask,

  /// xác nhận chọn task mới khi task hiện tại đang chạy
  confirmChangeTask,

  /// có lỗi xảy ra
  failue
}

final class PromodorTaskState extends Equatable {
  final TaskModel? selectedTask;

  /// task để chờ cập nhật nếu khi [askConfirmChangeTask] là true
  final TaskModel? penddingTask;
  final PromodorTaskStatus status;

  const PromodorTaskState({
    this.selectedTask,
    this.penddingTask, 
    this.status = PromodorTaskStatus.initial, 
  });

  PromodorTaskState copyWith({
    TaskModel? selectedTask,
    TaskModel? penddingTask,
    PromodorTaskStatus? status,
  }) {
    return PromodorTaskState(
      selectedTask: selectedTask ?? this.selectedTask,
      status: status ?? this.status,
      penddingTask: penddingTask ?? this.penddingTask
    );
  }

  @override
  String toString() {
    return 'PromodorState('
      'selectedTask: $selectedTask, '
      'penddingTask: $penddingTask, '
      'status: $status'
      ')';
  }

  
  @override
  List<Object?> get props => [status, selectedTask, penddingTask];
}