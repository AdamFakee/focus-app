import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/icon_picker/icon_picker_bloc.dart';
import 'package:focus_app/features/task/views/screens/add_new_task/add_new_task_page.dart';
import 'package:focus_app/utils/data/icons/font_awesome_icon_model.dart';
import 'package:focus_app/utils/data/icons/font_awesome_icons.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => IconPickerBloc(
          fetchFn: _fetchIcons
        )),
      ],
      child: AddNewTaskPage(),
    );
  }
}



Future<List<FontAwesomeIconModel>> _fetchIcons(int pageKey, String? search) async {
  int pageSize = 30;

  final filteredIcons = fontAwesomeIcons
      .where((icon) => search == null || icon.title.toLowerCase().contains(search.toLowerCase()))
      .toList();

  final startIndex = pageKey * pageSize;
  if (startIndex >= filteredIcons.length) return [];

  final endIndex = (startIndex + pageSize).clamp(0, filteredIcons.length);
  return filteredIcons.sublist(startIndex, endIndex);
}
