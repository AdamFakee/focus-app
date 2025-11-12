import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

final List<String> _projects = ['Pomodoro App', 'E-Commerce App', 'Social & Charity', 'AI Chatbot App'];


class ProjectDropdown extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const ProjectDropdown({super.key, this.selectedValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.sm,
      children: [
        const SectionLable(title: 'Project'),
        DropdownButtonFormField<String>(
          value: selectedValue,
          style: Theme.of(context).textTheme.bodyMedium,
          onChanged: onChanged,
          hint: Text('Select project', style: Theme.of(context).textTheme.bodyMedium,),
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.lightGray,
            contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.md, vertical: 4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
          ),
          items: _projects.map((project) {
            return DropdownMenuItem(value: project, child: Text(project, style: Theme.of(context).textTheme.bodyMedium,));
          }).toList(),
        ),
      ],
    );
  }
}