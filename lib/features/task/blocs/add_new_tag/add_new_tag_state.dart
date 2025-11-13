part of 'add_new_tag_bloc.dart';

enum SubmissionStatus { initial, loading, success, failure }

@immutable
class AddNewTagState extends Equatable {
  final bool isLoading;
  final SubmissionStatus status;
  final String? tagName;
  final Color? color;
  final String? errorMessage;

  const AddNewTagState({
    this.isLoading = false,
    this.status = SubmissionStatus.initial,
    this.tagName,
    this.color,
    this.errorMessage,
  });

  AddNewTagState copyWith({
    bool? isLoading,
    SubmissionStatus? status,
    String? tagName,
    Color? color,
    String? errorMessage,
  }) {
    return AddNewTagState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      tagName: tagName ?? this.tagName,
      color: color ?? this.color,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, status, tagName, color, errorMessage];
}
