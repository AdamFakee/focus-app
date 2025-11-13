part of 'edit_tag_bloc.dart';

@immutable
sealed class EditTagEvent extends Equatable {
  const EditTagEvent();
}

final class EditTagFetched extends EditTagEvent {
  final int tagId;
  const EditTagFetched(this.tagId);

  @override
  List<Object?> get props => [tagId];
}

final class EditTagNameChanged extends EditTagEvent {
  final String tagName;
  const EditTagNameChanged(this.tagName);

  @override
  List<Object?> get props => [tagName];
}

final class EditTagColorChanged extends EditTagEvent {
  final Color color;
  const EditTagColorChanged(this.color);

  @override
  List<Object?> get props => [color];
}

final class EditTagSubmitted extends EditTagEvent {
  const EditTagSubmitted();

  @override
  List<Object?> get props => [];
}

final class EditTagReset extends EditTagEvent {
  const EditTagReset();

  @override
  List<Object?> get props => [];
}
