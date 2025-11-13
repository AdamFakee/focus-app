import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/common/widgets/buttons/cancel_confirm_buttons.dart';
import 'package:focus_app/features/task/blocs/add_new_project/add_new_project_bloc.dart';
import 'package:focus_app/features/task/views/widgets/add_new_tag/input_name_field.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/color_picker.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class AddNewProjectPage extends StatelessWidget {
  const AddNewProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: 'Add New Project',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          spacing: Sizes.spaceBtwSections,
          children: [
            BlocSelector<AddNewProjectBloc, AddNewProjectState, String?>(
              selector: (state) {
                return state.projectName;
              },
              builder: (context, state) {
                return InputIconNameField(
                  onChangeText: (text) {
                    context.read<AddNewProjectBloc>().add(
                      AddNewProjectNameChanged(projectName: text),
                    );
                  },
                  sectionTitle: 'Project Name',
                );
              },
            ),
            BlocSelector<AddNewProjectBloc, AddNewProjectState, Color?>(
              selector: (state) {
                return state.color;
              },
              builder: (context, state) {
                return ColorPickerWidget(
                  selectedColor: state,
                  onColorSelected: (Color color) {
                    context.read<AddNewProjectBloc>().add(
                      AddNewProjectColorChanged(color: color),
                    );
                  },
                );
              },
            ),
            const Spacer(),
            CancelConfirmButtons(
              onConfirmed: () {
                context.read<AddNewProjectBloc>().add(
                  AddNewProjectSubmmited(),
                );
              }, 
              onCanceled: () {
                context.read<AddNewProjectBloc>().add(
                  AddNewProjectReset(),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
