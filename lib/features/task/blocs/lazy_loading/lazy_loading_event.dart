part of 'lazy_loading_bloc.dart';

@immutable
sealed class LazyLoadingEvent {
  const LazyLoadingEvent();
}

final class LazyLoadingFetchNext extends LazyLoadingEvent {}

final class LazyLoadingRefresh extends LazyLoadingEvent {}

final class LazyLoadingSearch extends LazyLoadingEvent {
  const LazyLoadingSearch(this.search);

  final String? search;
}