import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class TagFloatingButton extends StatelessWidget {
  const TagFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(Sizes.all)
      ),
      backgroundColor: AppColors.primary,
      onPressed: () {  },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}