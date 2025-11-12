import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class PomodoroSelector extends StatelessWidget {
  final int? selectedValue;
  final ValueChanged<int> onSelected;

  const PomodoroSelector({super.key, this.selectedValue, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.sm,
      children: [
        const SectionLable(title: 'Estimated Pomodoros'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(10, (index) {
              final value = index + 1;
              final isSelected = selectedValue == value;
              return Padding(
                padding: EdgeInsets.only(right: Sizes.sm),
                child: RoundedContainer(
                  onPressed: () => onSelected(value),
                  bg: isSelected ? AppColors.primary : Colors.transparent,
                  border: Border.all(color: AppColors.gray),
                  width: 30,
                  height: 30,
                  px: 0,
                  py: 0,
                  child: Center(
                    child: Text(
                      '$value',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: isSelected ? AppColors.white : AppColors.black,
                          ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}