part of 'icon_picker_bloc.dart';

// @immutable
// sealed class IconPickerState {
//   const IconPickerState();
// }

// final class IconPickerInitial extends IconPickerState {}

// final class IconPickerSuccess extends IconPickerState {
//   final List<FontAwesomeIconModel> icons;
//   final bool hasReachedMax; // Đã đến trang cuối cùng hay chưa

//   const IconPickerSuccess({
//     this.icons = const [],
//     this.hasReachedMax = false,
//   });

//   IconPickerSuccess copyWith({
//     List<FontAwesomeIconModel>? icons,
//     bool? hasReachedMax,
//   }) {
//     return IconPickerSuccess(
//       icons: icons ?? this.icons,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//     );
//   }
// }

// // Trạng thái khi có lỗi xảy ra
// final class IconPickerFailure extends IconPickerState {
//   final String error;

//   const IconPickerFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }


@immutable
final class IconPickerState extends PagingStateBase<int, FontAwesomeIconModel> {
  IconPickerState({
    super.pages,
    super.keys,
    super.error,
    super.hasNextPage,
    super.isLoading,
    this.search,
  });

  final String? search;

  @override
  IconPickerState copyWith({
    Defaulted<List<List<FontAwesomeIconModel>>?>? pages = const Omit(),
    Defaulted<List<int>?>? keys = const Omit(),
    Defaulted<Object?>? error = const Omit(),
    Defaulted<bool>? hasNextPage = const Omit(),
    Defaulted<bool>? isLoading = const Omit(),
    Defaulted<String?> search = const Omit(),
  }) =>
      IconPickerState(
        pages: pages is Omit ? this.pages : pages as List<List<FontAwesomeIconModel>>?,
        keys: keys is Omit ? this.keys : keys as List<int>?,
        error: error is Omit ? this.error : error,
        hasNextPage:
            hasNextPage is Omit ? this.hasNextPage : hasNextPage as bool,
        isLoading: isLoading is Omit ? this.isLoading : isLoading as bool,
        search: search is Omit ? this.search : search as String?,
      );

  @override
  IconPickerState reset() => IconPickerState(
    pages: null,
    keys: null,
    error: null,
    hasNextPage: true,
    isLoading: false,
    search: search,
  );

  @override
  bool operator ==(Object other) =>
      other is IconPickerState &&
      super == (other) &&
      search == other.search;

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        search,
      );
}