import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';



/// A class show confirm popup (dialog)
class ConfirmPopup {
  /// Function onpen or show popup
  /// 
  /// When tap in "barrier area" return false
  static Future<bool> show({
    String title = "Are you sure?",
    String? content,
    String textConfirm = "Yes",
    String textCancel = "No",
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(Sizes.sm)
          ),
          // mặc định là 8px
          actionsPadding: EdgeInsets.only(left: Sizes.lg, right: Sizes.lg, top: 0, bottom: Sizes.lg),
          // mặc định là 24px
          contentPadding: EdgeInsetsGeometry.symmetric(
            horizontal: Sizes.lg,
            vertical: Sizes.sm
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          content: content != null ? Text(content, style: Theme.of(context).textTheme.labelMedium,) : null,
          actions: [
            Row(
              spacing: Sizes.md,
              children: [
                // button confirm
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      close(true, context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes.sm,
                        horizontal: Sizes.md,
                      ),
                    ),
                    child: Text(textConfirm, style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: AppColors.black
                    ),),
                  ),
                ),

                // button cancle
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      close(false, context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes.sm,
                        horizontal: Sizes.md,
                      ),
                    ),
                    child: Text(textCancel,),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ) ?? false;
  }

  /// Function close popup and return [value]
  static void close(bool value, BuildContext context) => Navigator.of(context).pop(value);
}
