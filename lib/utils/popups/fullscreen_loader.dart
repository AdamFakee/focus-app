import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/extensions/context_extensions.dart';

class FullscreenLoader {
  static show (BuildContext context) {
    showDialog(
      context: context, 
      builder:(ctx) {
        return SizedBox(
          height: ctx.screenHeight(),
          width: ctx.screenWidht(),
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }

  static stop (BuildContext context) => Navigator.pop(context);
}