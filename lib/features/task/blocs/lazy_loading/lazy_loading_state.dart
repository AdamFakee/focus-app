part of 'lazy_loading_bloc.dart';

@immutable
final class LazyLoadingState<T> extends PagingStateBase<int, T> {
  LazyLoadingState({
    super.pages,
    super.keys,
    super.error,
    super.hasNextPage,
    super.isLoading,
    this.search,
  });

  final String? search;

  @override
  LazyLoadingState<T> copyWith({
    Defaulted<List<List<T>>?>? pages = const Omit(),
    Defaulted<List<int>?>? keys = const Omit(),
    Defaulted<Object?>? error = const Omit(),
    Defaulted<bool>? hasNextPage = const Omit(),
    Defaulted<bool>? isLoading = const Omit(),
    Defaulted<String?> search = const Omit(),
  }) =>
      LazyLoadingState(
        pages: pages is Omit ? this.pages : pages as List<List<T>>?,
        keys: keys is Omit ? this.keys : keys as List<int>?,
        error: error is Omit ? this.error : error,
        hasNextPage:
            hasNextPage is Omit ? this.hasNextPage : hasNextPage as bool,
        isLoading: isLoading is Omit ? this.isLoading : isLoading as bool,
        search: search is Omit ? this.search : search as String?,
      );

  @override
  LazyLoadingState<T> reset() => LazyLoadingState(
    pages: null,
    keys: null,
    error: null,
    hasNextPage: true,
    isLoading: false,
    search: search,
  );

  @override
  bool operator ==(Object other) =>
      other is LazyLoadingState &&
      super == (other) &&
      search == other.search;

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        search,
      );
}