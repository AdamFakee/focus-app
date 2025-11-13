import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/tag_repo.dart';

part 'delete_tag_event.dart';
part 'delete_tag_state.dart';

class DeleteTagBloc extends Bloc<DeleteTagEvent, DeleteTagState> {
  final TagRepo _tagRepo;

  DeleteTagBloc({
    required TagRepo tagRepo,
  })  : _tagRepo = tagRepo,
        super(const DeleteTagState()) {
    on<DeleteTagSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    DeleteTagSubmitted event,
    Emitter<DeleteTagState> emit,
  ) async {
    emit(state.copyWith(status: SubmissionStatus.loading));

    try {
      await _tagRepo.deleteTag(event.tagId);

      emit(state.copyWith(status: SubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}