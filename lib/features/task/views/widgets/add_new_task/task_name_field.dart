import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/utils/const/sizes.dart';

class TaskNameField extends StatelessWidget {
  final TextEditingController controller;
  const TaskNameField({super.key, required this.controller});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.sm,
      children: [
        const SectionLable(title: 'Task Name'),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'e.g. Write proposal, Designing, etc.',
          ),
        ),
      ],
    );
  }
}
