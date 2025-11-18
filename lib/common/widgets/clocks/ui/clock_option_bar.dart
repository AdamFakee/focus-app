import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

/// Một thanh tùy chọn hiển thị các chế độ khác nhau cho phiên tập trung.
class ClockOptionBar extends StatelessWidget {
  const ClockOptionBar({
    super.key,
    required this.onStrictModePressed,
    required this.onStopPressed,
    required this.onFullScreenPressed,
    required this.onWhiteNoisePressed,
  });

  final VoidCallback onStrictModePressed;

  /// Dừng pomodor section
  final VoidCallback onStopPressed;
  final VoidCallback onFullScreenPressed;
  final VoidCallback onWhiteNoisePressed;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      py: Sizes.md,
      px: Sizes.sm,
      bg: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildOption(
            context,
            icon: Icons.error_outline,
            label: 'Strict Mode',
            onTap: onStrictModePressed,
          ),
          _buildOption(
            context,
            icon: Icons.hourglass_empty_outlined,
            label: 'Stop Timer',
            onTap: onStopPressed,
          ),
          _buildOption(
            context,
            icon: Icons.fullscreen,
            label: 'Full Screen',
            onTap: onFullScreenPressed,
          ),
          _buildOption(
            context,
            icon: Icons.music_note_outlined,
            label: 'White Noise',
            onTap: onWhiteNoisePressed,
          ),
        ],
      ),
    );
  }

  /// Widget con để xây dựng một mục tùy chọn có thể nhấn được.
  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Sizes.md),
      child: Padding(
        // Thêm padding để tăng vùng có thể nhấn
        padding: const EdgeInsets.symmetric(horizontal: Sizes.xs, vertical: Sizes.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.black, size: 24),
            const SizedBox(height: Sizes.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}