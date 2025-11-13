import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/data/repos/tag_repo.dart';
import 'package:focus_app/features/task/models/tag_model.dart';

part 'add_new_tag_event.dart';
part 'add_new_tag_state.dart';

class AddNewTagBloc extends Bloc<AddNewTagEvent, AddNewTagState> {
  final TagRepo _tagRepo;
  
  AddNewTagBloc({
    required TagRepo tagRepo
  }) :
    _tagRepo = tagRepo, 
    super(const AddNewTagState()) {
      on<AddNewTagNameChanged>(_onNameChanged);
      on<AddNewTagColorChanged>(_onColorChanged);
      on<AddNewTagSubmmited>(_onSubmitted);
      on<AddNewTagReset>(_onReset);
    }

  void _onNameChanged(AddNewTagNameChanged event, Emitter emit) {
    emit(state.copyWith(
      tagName: event.tagName
    ));
  }

  void _onColorChanged(AddNewTagColorChanged event, Emitter emit) {
    emit(state.copyWith(
      color: event.color
    ));
  }

  Future<void> _onSubmitted(AddNewTagSubmmited event, Emitter emit) async {
    // Validation
    if(state.color == null) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Please fill color'
      ));
      return;
    }

    if(state.tagName == null) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: 'Please fill tag name'
      ));
      return;
    }
    // End validation

    // loading
    emit(state.copyWith(status: SubmissionStatus.loading));

    try {
      final newTag = TagModel(
        color: state.color!,
        createdAt: DateTime.now(),
        tagName: state.tagName!
      );

      await _tagRepo.createTag(newTag);


      emit(state.copyWith(
        status: SubmissionStatus.success, 
        isLoading: false
      ));

      // reset form
      add(AddNewTagReset());

    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: e.toString(),
        isLoading: false
      ));
    }
  }

  void _onReset(AddNewTagReset event, Emitter emit) {
    emit(AddNewTagState());
  }
}
