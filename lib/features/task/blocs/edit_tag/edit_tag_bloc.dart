import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/tag_repo.dart';
import 'package:focus_app/features/task/models/tag_model.dart';

part 'edit_tag_event.dart';
part 'edit_tag_state.dart';

class EditTagBloc extends Bloc<EditTagEvent, EditTagState> {
  final TagRepo _tagRepo;

  EditTagBloc({
    required TagRepo tagRepo,
  })  : _tagRepo = tagRepo,
        super(const EditTagState()) {
    on<EditTagFetched>(_onFetched);
    on<EditTagNameChanged>(_onNameChanged);
    on<EditTagColorChanged>(_onColorChanged);
    on<EditTagSubmitted>(_onSubmitted);
    on<EditTagReset>(_onReset);
  }

  /// Fetch tag by ID
  Future<void> _onFetched(EditTagFetched event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final tag = await _tagRepo.getTagById(event.tagId);
      emit(state.copyWith(
        isLoading: false,
        tagId: tag.tagId,
        tagName: tag.tagName,
        color: tag.color,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        status: SubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onNameChanged(EditTagNameChanged event, Emitter emit) {
    emit(state.copyWith(tagName: event.tagName));
  }

  void _onColorChanged(EditTagColorChanged event, Emitter emit) {
    emit(state.copyWith(color: event.color));
  }

  Future<void> _onSubmitted(EditTagSubmitted event, Emitter emit) async {
    // Validation
    if (state.tagName == null || state.tagName!.isEmpty) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Missing tag name',
      ));
      return;
    }

    if (state.color == null) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Missing color',
      ));
      return;
    }
    // End validation

    emit(state.copyWith(
      status: SubmissionStatus.loading,
      isLoading: true,
    ));

    try {
      final updatedTag = TagModel(
        tagId: state.tagId,
        tagName: state.tagName!,
        color: state.color!,
        createdAt: DateTime.now(),
      );

      await _tagRepo.updateTag(updatedTag);

      emit(state.copyWith(
        status: SubmissionStatus.success,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onReset(EditTagReset event, Emitter emit) {
    emit(const EditTagState());
  }
}
