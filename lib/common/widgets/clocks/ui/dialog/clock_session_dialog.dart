import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/buttons/cancel_confirm_buttons.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:go_router/go_router.dart';

/// Một hộp thoại để làm gì đó với phiên tập trung.
class ClockSessionDialog extends StatelessWidget {
  final String title;
  final String desc;
  final VoidCallback onConfirmed;
  final String confirmTitle;

  const ClockSessionDialog({
    super.key, 
    required this.title, 
    required this.desc,
    required this.onConfirmed,
    required this.confirmTitle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.md),
      child: Column(
        spacing: Sizes.sm,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tiêu đề
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),

          // Mô tả
          Column(
            spacing: Sizes.md,
            children: [
              Divider(),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Divider(),
            ],
          ),
          const SizedBox(height: Sizes.spaceBtwSections),

          // Hàng chứa các nút bấm
          CancelConfirmButtons(
            onConfirmed: () {
              onConfirmed();
              context.pop();
            }, 
            onCanceled: () { 
              context.pop();
            },
            confirmTitle: confirmTitle,
          )
        ],
      ),
    );
  }
}