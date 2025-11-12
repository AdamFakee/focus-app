part of 'icon_picker_bloc.dart';

@immutable
sealed class IconPickerEvent {
  const IconPickerEvent();
}

final class IconPickerFetchNext extends IconPickerEvent {}

final class IconPickerRefresh extends IconPickerEvent {}

final class IconPickerSearch extends IconPickerEvent {
  const IconPickerSearch(this.search);

  final String? search;
}