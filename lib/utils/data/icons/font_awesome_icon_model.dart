import 'package:flutter/widgets.dart';

class FontAwesomeIconModel implements Comparable {
  final IconData iconData;
  final String title;

  FontAwesomeIconModel(this.iconData, this.title);

  @override
  String toString() => 'IconDefinition{iconData: $iconData, title: $title}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FontAwesomeIconModel &&
          runtimeType == other.runtimeType &&
          iconData == other.iconData &&
          title == other.title;

  @override
  int get hashCode => iconData.hashCode ^ title.hashCode;

  @override
  int compareTo(other) => title.compareTo(other.title);
}
