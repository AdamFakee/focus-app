part of 'edit_tag_bloc.dart';

enum SubmissionStatus { initial, loading, success, failure }

@immutable
class EditTagState extends Equatable {
  final bool isLoading;
  final SubmissionStatus status;
  final int? tagId;
  final String? tagName;
  final Color? color;
  final String? errorMessage;

  const EditTagState({
    this.isLoading = false,
    this.status = SubmissionStatus.initial,
    this.tagId,
    this.tagName,
    this.color,
    this.errorMessage,
  });

  EditTagState copyWith({
    bool? isLoading,
    SubmissionStatus? status,
    int? tagId,
    String? tagName,
    Color? color,
    String? errorMessage,
  }) {
    return EditTagState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      tagId: tagId ?? this.tagId,
      tagName: tagName ?? this.tagName,
      color: color ?? this.color,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        status,
        tagId,
        tagName,
        color,
        errorMessage,
      ];
}
