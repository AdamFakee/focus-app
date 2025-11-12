import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/common/widgets/buttons/cancel_confirm_buttons.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/color_picker.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/icon_picker.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/pomodoro_selector.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/project_drop_down.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/tags_selector.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/task_name_field.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/data/colors/task_colors.dart';


// --- Widget Màn hình Chính ---

class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  // --- Biến Trạng thái ---
  final _taskNameController = TextEditingController();
  IconData? _selectedIcon;
  int? _selectedPomodoro;
  String? _selectedProject;
  final Set<String> _selectedTags = {};
  Color _selectedColor = taskColors.first;

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: 'Add New Task',
        centerTitle: true,
      ),
      body: Padding(
    padding: const EdgeInsets.fromLTRB(Sizes.lg, 0, Sizes.lg, Sizes.lg),
    child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing: Sizes.lg,
              children: [
                //- icon picker
                Center(
                  child: IconPicker(
                    selectedIcon: _selectedIcon,
                    selectedColor: _selectedColor,
                  )
                ),

                //- task name
                TaskNameField(controller: _taskNameController),

                //- pomodoro
                PomodoroSelector(
                  selectedValue: _selectedPomodoro,
                  onSelected: (value) => setState(() => _selectedPomodoro = value),
                ),

                //- project
                ProjectDropdown(
                  selectedValue: _selectedProject,
                  onChanged: (value) => setState(() => _selectedProject = value),
                ),

                //- tag
                TagSelector(
                  selectedTags: _selectedTags,
                  onSelected: (tag) {
                    setState(() {
                      if (_selectedTags.contains(tag)) {
                        _selectedTags.remove(tag);
                      } else {
                        _selectedTags.add(tag);
                      }
                    });
                  },
                ),

                //- color
                ColorPickerWidget(
                  selectedColor: _selectedColor,
                  onColorSelected: (color) => setState(() => _selectedColor = color),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: Sizes.lg),
        CancelConfirmButtons(
          onCanceled: () {},
          onConfirmed: () {},
        ),
      ],
    ),
  ),
    );
  }
}