import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/project_repo.dart';

part 'delete_project_event.dart';
part 'delete_project_state.dart';

class DeleteProjectBloc extends Bloc<DeleteProjectEvent, DeleteProjectState> {
  final ProjectRepo _projectRepo;

  DeleteProjectBloc({
    required ProjectRepo projectRepo,
  })  : _projectRepo = projectRepo,
        super(const DeleteProjectState()) {
    on<DeleteProjectSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    DeleteProjectSubmitted event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: SubmissionStatus.loading));

    try {
      await _projectRepo.deleteProject(event.projectId);

      emit(state.copyWith(status: SubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}