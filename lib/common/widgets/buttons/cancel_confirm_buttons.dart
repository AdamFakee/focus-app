import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class CancelConfirmButtons extends StatelessWidget {
  final VoidCallback onConfirmed;
  final VoidCallback onCanceled;
  final String cancelTitle;
  final String confirmTitle;

  const CancelConfirmButtons({
    super.key,
    required this.onConfirmed,
    required this.onCanceled,
    this.cancelTitle = "Cancel",
    this.confirmTitle = "Confirm",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Nút "Cancel"
        Expanded(
          child: OutlinedButton(
            onPressed: onCanceled,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.red,
              backgroundColor: AppColors.red.withOpacity(0.1),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(vertical: Sizes.md),
            ),
            child: Text(cancelTitle),
          ),
        ),
        const SizedBox(width: Sizes.spaceBtwItems),

        // Nút "Yes"
        Expanded(
          child: ElevatedButton(
            onPressed: onConfirmed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: Sizes.md),
            ),
            child: Text(confirmTitle),
          ),
        ),
      ],
    );
  }
}
