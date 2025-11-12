import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/utils/data/icons/font_awesome_icon_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

part 'icon_picker_event.dart';
part 'icon_picker_state.dart';

class IconPickerBloc extends Bloc<IconPickerEvent, IconPickerState> {
  IconPickerBloc({
    required this.fetchFn
  }) : super(IconPickerState()) {
    on<IconPickerFetchNext>(_onFetchNext);
    on<IconPickerRefresh>(_onRefesh);
    on<IconPickerSearch>(_onSearch);
  }

  final Future<List<FontAwesomeIconModel>> Function(int pageKey, String? search)? fetchFn;

  Future<void> _onFetchNext(
    IconPickerFetchNext event,
    Emitter<IconPickerState> emit,
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
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  void _onRefesh(IconPickerRefresh event, Emitter<IconPickerState> emit) {
    emit(state.reset());
    add(IconPickerFetchNext());
  }


  void _onSearch(IconPickerSearch event, Emitter<IconPickerState> emit) {
    emit(state.reset().copyWith(search: event.search));
    add(IconPickerFetchNext());
  }

}
