import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/features/task/blocs/edit_tag/edit_tag_bloc.dart';
import 'package:focus_app/features/task/views/widgets/common/input_name_field.dart';
import 'package:focus_app/features/task/views/widgets/common/color_picker.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class EditTagPage extends StatelessWidget {
  const EditTagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: 'Edit Tag',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          spacing: Sizes.spaceBtwSections,
          children: [
            BlocSelector<EditTagBloc, EditTagState, ({String? tagName, Color? color})>(
              selector: (state) {
                return (tagName: state.tagName, color: state.color);
              },
              builder: (context, state) {
                return InputIconNameField(
                  defaultValue: state.tagName,
                  iconColor: state.color,
                  onChangeText: (text) {
                    context.read<EditTagBloc>().add(
                      EditTagNameChanged(text),
                    );
                  },
                  sectionTitle: 'Tag Name',
                );
              },
            ),
            BlocSelector<EditTagBloc, EditTagState, Color?>(
              selector: (state) {
                return state.color;
              },
              builder: (context, state) {
                return ColorPickerWidget(
                  selectedColor: state,
                  onColorSelected: (Color color) {
                    context.read<EditTagBloc>().add(
                      EditTagColorChanged(color),
                    );
                  },
                );
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<EditTagBloc>().add(
                  EditTagSubmitted(),
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
