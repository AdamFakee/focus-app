import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskCard extends StatelessWidget {
  /// Icon chính bên trái
  final IconData mainIcon;

  /// Màu nền của icon chính
  final Color? mainIconBackgroundColor;

  /// Tiêu đề của task
  final String title;

  /// Text hiển thị tiến độ (ví dụ: "4/6")
  final String progressText;

  /// Text hiển thị thời gian (ví dụ: "100/150 mins")
  final String durationText;

  /// Widget sẽ hiển thị ở cuối hàng (bên phải)
  final Widget? trailing;

  /// Callback khi nhấn vào card
  final VoidCallback? onTap;

  /// Cờ xác định task đã hoàn thành hay chưa. Mặc định là false.
  /// Khi true, card sẽ bị làm mờ và text có gạch ngang.
  final bool isCompleted;

  const TaskCard({
    super.key,
    required this.mainIcon,
    required this.title,
    required this.progressText,
    required this.durationText,
    this.trailing,
    this.mainIconBackgroundColor,
    this.onTap,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    // Xác định style cho text dựa trên trạng thái isCompleted
    final textDecoration = isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final decorationColor = isCompleted ? AppColors.gray : null;

    return Opacity(
      opacity: isCompleted ? 0.7 : 1.0,
      child: RoundedContainer(
        px: 0,
        py: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Sizes.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.md, vertical: Sizes.sm * 1.5),
            child: Row(
              children: [
                // 1. Icon chính bên trái
                IconContainer(
                  icon: mainIcon,
                  backgroundColor: mainIconBackgroundColor ?? AppColors.primary,
                  iconColor: Colors.white,
                  size: 52,
                ),
            
                const SizedBox(width: Sizes.md),
            
                // 2. Cụm text ở giữa
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tiêu đề
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: textDecoration,
                          decorationColor: decorationColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Sizes.sm),
                      // Hàng thông tin phụ
                      _buildMetadataRow(textDecoration, decorationColor),
                    ],
                  ),
                ),
            
                const SizedBox(width: Sizes.sm),
            
                // 3. Widget ở cuối
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Widget con để hiển thị thông tin phụ (tiến độ và thời gian)
  Widget _buildMetadataRow(TextDecoration textDecoration, Color? decorationColor) {
    final metadataStyle = TextStyle(
      color: AppColors.gray,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(FontAwesomeIcons.clock, size: 16, color: AppColors.gray),
        const SizedBox(width: Sizes.xs),
        Text(progressText, style: metadataStyle),
        const SizedBox(width: Sizes.sm),
        Text('·', style: TextStyle(color: AppColors.gray, fontWeight: FontWeight.bold)),
        const SizedBox(width: Sizes.sm),
        Text(durationText, style: metadataStyle),
      ],
    );
  }
}