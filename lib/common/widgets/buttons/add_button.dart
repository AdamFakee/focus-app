import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class AddButtonCommon extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const AddButtonCommon({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Sizes.md,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
              fontSizeDelta: 1.4
            ),
          ),
          Icon(Icons.add, color: AppColors.black,),
        ],
      )
    );
  }
}