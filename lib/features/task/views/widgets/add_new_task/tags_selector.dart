import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

final List<String> _tags = ['General', 'Design', 'Urgent', 'Work', 'Personal', 'Development'];

class TagSelector extends StatelessWidget {
  final Set<String> selectedTags;
  final ValueChanged<String> onSelected;

  const TagSelector({super.key, required this.selectedTags, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.sm,
      children: [
        const SectionLable(title: 'Tags'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: Sizes.sm,
            mainAxisSize: MainAxisSize.min,
            children: _tags.map((tag) {
              final isSelected = selectedTags.contains(tag);
              return RoundedContainer(
                radius: Sizes.lg,
                bg: isSelected ? AppColors.primary : Colors.transparent,
                onPressed: () => onSelected(tag),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.gray
                ),
                child: Text(tag),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
