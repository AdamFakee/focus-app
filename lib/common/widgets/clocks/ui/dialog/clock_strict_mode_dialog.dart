import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/buttons/cancel_confirm_buttons.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class ClockStrictModeDialog extends StatefulWidget {
  const ClockStrictModeDialog({super.key});

  @override
  State<ClockStrictModeDialog> createState() => _ClockStrictModeDialogState();
}

class _ClockStrictModeDialogState extends State<ClockStrictModeDialog> {
  // Biến trạng thái cho các công tắc
  bool _blockNotifications = true;
  bool _blockPhoneCalls = true;
  bool _blockOtherApps = false;
  bool _lockPhone = false;
  bool _prohibitToExit = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tiêu đề
          Text(
            "Strict Mode",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Sizes.spaceBtwSections),

          // Danh sách các tùy chọn
          Column(
            children: [
              _buildOptionRow(
                title: "Block All Notifications",
                value: _blockNotifications,
                onChanged: (value) => setState(() => _blockNotifications = value),
              ),
              const SizedBox(height: Sizes.md),
              _buildOptionRow(
                title: "Block Phone Calls",
                value: _blockPhoneCalls,
                onChanged: (value) => setState(() => _blockPhoneCalls = value),
              ),
              const SizedBox(height: Sizes.md),
              _buildOptionRow(
                title: "Block Other Apps",
                value: _blockOtherApps,
                onChanged: (value) => setState(() => _blockOtherApps = value),
              ),
              const SizedBox(height: Sizes.md),
              _buildOptionRow(
                title: "Lock Phone",
                value: _lockPhone,
                onChanged: (value) => setState(() => _lockPhone = value),
              ),
              const SizedBox(height: Sizes.md),
              _buildOptionRow(
                title: "Prohibit to Exit",
                value: _prohibitToExit,
                onChanged: (value) => setState(() => _prohibitToExit = value),
              ),
            ],
          ),
          const SizedBox(height: Sizes.spaceBtwSections * 1.5),

          // Hàng chứa các nút bấm
          CancelConfirmButtons(
            onConfirmed: () {

            }, 
            onCanceled: () {

            },
            confirmTitle: "Save",
          )
        ],
      ),
    );
  }

  /// Widget con để xây dựng một hàng tùy chọn với tiêu đề và công tắc.
  Widget _buildOptionRow({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        // Sử dụng CupertinoSwitch để có giao diện giống iOS
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.red,
        ),
      ],
    );
  }
}