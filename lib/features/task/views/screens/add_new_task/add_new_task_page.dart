import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/common/widgets/buttons/cancel_confirm_buttons.dart';
import 'package:focus_app/features/task/blocs/add_new_task/add_new_task_bloc.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/color_picker.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/icon_picker.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/pomodoro_selector.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/project_drop_down.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/tags_selector.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/input_name_field.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  @override
  void dispose() {
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
                    Center(child: IconPicker()),

                    //- task name
                    InputNameField(
                      sectionTitle: 'Task Name',
                      onChangeText: (text) {
                        context.read<AddNewTaskBloc>().add(
                          AddNewTaskNameChanged(text),
                        );
                      },
                    ),

                    //- pomodoro
                    PomodoroSelector(),

                    //- project
                    ProjectDropdown(),

                    //- tag
                    TagSelector(),

                    //- color
                    BlocSelector<AddNewTaskBloc, AddNewTaskState, Color?>(
                      selector: (state) {
                        return state.color;
                      },
                      builder: (context, state) {
                        return ColorPickerWidget(
                          selectedColor: state,
                          onColorSelected: (color) {
                            context.read<AddNewTaskBloc>().add(AddNewTaskColorChanged(color));
                          }
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: Sizes.lg),
            CancelConfirmButtons(
              onCanceled: () {
                context.read<AddNewTaskBloc>().add(AddNewTaskSubmitted());
              },
              onConfirmed: () {
                context.read<AddNewTaskBloc>().add(AddNewTaskSubmitted());
              },
            ),
          ],
        ),
      ),
    );
  }
}
