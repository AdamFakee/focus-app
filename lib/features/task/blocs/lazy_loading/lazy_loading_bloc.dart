import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

part 'lazy_loading_event.dart';
part 'lazy_loading_state.dart';

class LazyLoadingBloc<T> extends Bloc<LazyLoadingEvent, LazyLoadingState<T>> {
  LazyLoadingBloc({
    required this.fetchFn
  }) : super(LazyLoadingState<T>()) {
    on<LazyLoadingFetchNext>(_onFetchNext);
    on<LazyLoadingRefresh>(_onRefesh);
    on<LazyLoadingSearch>(_onSearch);
  }

  final Future<List<T>> Function(int pageKey, String? search)? fetchFn;

  Future<void> _onFetchNext(
    LazyLoadingFetchNext event,
    Emitter<LazyLoadingState> emit,
  ) async {
    final current = state;
    if (current.isLoading || !current.hasNextPage) return;

    final pageKey = current.lastPageIsEmpty ? null : current.nextIntPageKey;
    if (pageKey == null) {
      emit(current.copyWith(hasNextPage: false));
      return;
    }

    emit(current.copyWith(
      isLoading: true,
      error: null,
    ));

    try {
      final result = await fetchFn!(pageKey, current.search);

      final isLastPage = result.isEmpty;
      emit(state.copyWith(
        isLoading: false,
        error: null,
        hasNextPage: !isLastPage,
        pages: [...?state.pages, result],
        keys: [...?state.keys, pageKey],
      ));
    } catch (e, stack) {
      print(e);
      print(stack);
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  void _onRefesh(LazyLoadingRefresh event, Emitter<LazyLoadingState> emit) {
    emit(state.reset());
    add(LazyLoadingFetchNext());
  }


  void _onSearch(LazyLoadingSearch event, Emitter<LazyLoadingState> emit) {
    emit(state.reset().copyWith(search: event.search));
    add(LazyLoadingFetchNext());
  }

}
