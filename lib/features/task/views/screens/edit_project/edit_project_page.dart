import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/features/task/blocs/edit_project/edit_project_bloc.dart';
import 'package:focus_app/features/task/views/widgets/common/input_name_field.dart';
import 'package:focus_app/features/task/views/widgets/common/color_picker.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class EditProjectPage extends StatelessWidget {
  const EditProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: 'Edit Project',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          spacing: Sizes.spaceBtwSections,
          children: [
            BlocSelector<EditProjectBloc, EditProjectState, ({String? projectName, Color? color})>(
              selector: (state) {
                return (projectName: state.projectName, color: state.color);
              },
              builder: (context, state) {
                return InputIconNameField(
                  defaultValue: state.projectName,
                  iconColor: state.color,
                  onChangeText: (text) {
                    context.read<EditProjectBloc>().add(
                      EditProjectNameChanged(text),
                    );
                  },
                  sectionTitle: 'Project Name',
                );
              },
            ),
            BlocSelector<EditProjectBloc, EditProjectState, Color?>(
              selector: (state) {
                return state.color;
              },
              builder: (context, state) {
                return ColorPickerWidget(
                  selectedColor: state,
                  onColorSelected: (Color color) {
                    context.read<EditProjectBloc>().add(
                      EditProjectColorChanged(color),
                    );
                  },
                );
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<EditProjectBloc>().add(
                  EditProjectSubmitted(),
                );
              }, 
              child: Text('Save')
            )
          ],
        ),
      ),
    );
  }
}
