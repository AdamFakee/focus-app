import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/buttons/cancel_confirm_buttons.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

// Enum để xác định các chế độ hẹn giờ
enum TimerMode { countdown, countUp }

class ClockTimerDialog extends StatefulWidget {
  const ClockTimerDialog({super.key});

  @override
  State<ClockTimerDialog> createState() => _ClockTimerDialogState();
}

class _ClockTimerDialogState extends State<ClockTimerDialog> {
  // Biến trạng thái để theo dõi chế độ được chọn, mặc định là countdown
  TimerMode _selectedMode = TimerMode.countdown;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.md),
      child: Column(
        spacing: Sizes.sm,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tiêu đề
          Text(
            "Timer Mode",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),

          // Danh sách các tùy chọn
          Column(
            children: [
              _buildOption(
                title: '25:00 → 00:00',
                subtitle: 'Countdown from 25 minutes until time runs out.',
                isSelected: _selectedMode == TimerMode.countdown,
                onTap: () => setState(() => _selectedMode = TimerMode.countdown),
              ),
              const Divider(height: Sizes.spaceBtwSections),
              _buildOption(
                title: '00:00 → ∞',
                subtitle: 'Start counting from 0 until stopped manually.',
                isSelected: _selectedMode == TimerMode.countUp,
                onTap: () => setState(() => _selectedMode = TimerMode.countUp),
              ),
            ],
          ),

          const SizedBox(height: Sizes.spaceBtwSections),

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

  /// Widget con để xây dựng một mục tùy chọn có thể nhấn được.
  Widget _buildOption({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Sizes.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.sm
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: Sizes.xs),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: Sizes.md, top: 4),
                child: Icon(Icons.check, color: AppColors.red, size: 24),
              ),
          ],
        ),
      ),
    );
  }
}