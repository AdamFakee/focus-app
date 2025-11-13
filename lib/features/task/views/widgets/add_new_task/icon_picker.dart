import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/features/task/blocs/add_new_task/add_new_task_bloc.dart';
import 'package:focus_app/features/task/views/widgets/common/icon_picker_dialog.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconPicker extends StatelessWidget {

  const IconPicker({super.key,});

  void pickIcon(BuildContext ctx) async {
    final selectedIcon = await showIconSelectionBottomSheet(ctx);

    if(selectedIcon != null && ctx.mounted) {
      ctx.read<AddNewTaskBloc>().add(AddNewTaskIconChanged(selectedIcon.iconData));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final color = context.watch<AddNewTaskBloc>().state.color;
    final icon = context.watch<AddNewTaskBloc>().state.icon;
    return GestureDetector(
      onTap: () => pickIcon(context),
      child: RoundedContainer(
        radius: Sizes.all,
        width: 80,
        height: 80,
        px: 0,
        py: 0,
        bg: icon != null ? color : AppColors.lightGray,
        child: icon != null
            ? Center(
              child: FaIcon(icon, size: 40, color: color == null ? AppColors.black : AppColors.white)
            )
            : const Icon(Icons.add, size: 40, color: AppColors.black),
      ),
    );
  }
}