part of 'delete_tag_bloc.dart';

sealed class DeleteTagEvent extends Equatable {
  const DeleteTagEvent();
}

final class DeleteTagSubmitted extends DeleteTagEvent {
  final int tagId;

  const DeleteTagSubmitted(this.tagId);

  @override
  List<Object> get props => [tagId];
}