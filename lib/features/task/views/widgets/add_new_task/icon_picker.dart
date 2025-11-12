import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/features/task/views/widgets/add_new_task/icon_picker_dialog.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class IconPicker extends StatelessWidget {
  final IconData? selectedIcon;
  final Color selectedColor;

  const IconPicker({super.key, 
    this.selectedIcon,
    required this.selectedColor,
  });

  void pickIcon(BuildContext ctx) async {
    final selectedIconModel = await showIconSelectionBottomSheet(ctx);
    print(selectedIconModel.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pickIcon(context),
      child: RoundedContainer(
        radius: Sizes.all,
        width: 80,
        height: 80,
        bg: selectedIcon != null ? selectedColor : AppColors.lightGray,
        child: selectedIcon != null
            ? Icon(selectedIcon, size: 40, color: Colors.white)
            : const Icon(Icons.add, size: 40, color: AppColors.black),
      ),
    );
  }
}