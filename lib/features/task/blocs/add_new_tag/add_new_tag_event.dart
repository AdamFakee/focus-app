part of 'add_new_tag_bloc.dart';

sealed class AddNewTagEvent extends Equatable {}

final class AddNewTagNameChanged extends AddNewTagEvent {
  final String tagName;

  AddNewTagNameChanged({required this.tagName});

  @override
  List<Object> get props => [tagName];
}

final class AddNewTagColorChanged extends AddNewTagEvent {
  final Color color;

  AddNewTagColorChanged({required this.color});

  @override
  List<Object> get props => [color];
}

final class AddNewTagSubmmited extends AddNewTagEvent {
  @override
  List<Object?> get props => [];
}

final class AddNewTagReset extends AddNewTagEvent {
  @override
  List<Object?> get props => [];
}