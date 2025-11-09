import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/const/colors.dart';

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

  const TaskCard({
    super.key,
    required this.mainIcon,
    required this.title,
    required this.progressText,
    required this.durationText,
    this.trailing,
    this.mainIconBackgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return RoundedContainer(
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Sizes.sm),
                    // Hàng thông tin phụ
                    _buildMetadataRow(),
                  ],
                ),
              ),

              const SizedBox(width: Sizes.sm),
          
              // 3. Widget ở cuối
              if(trailing != null) 
                trailing!,
            ],
          ),
        ),
      ),
    );
  }

  /// Widget con để hiển thị thông tin phụ (tiến độ và thời gian)
  Widget _buildMetadataRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.remove_red_eye_outlined, size: 16, color: AppColors.gray),
        const SizedBox(width: Sizes.xs),
        Text(progressText, style: TextStyle(color: AppColors.gray)),
        const SizedBox(width: Sizes.sm),
        Text('·', style: TextStyle(color: AppColors.gray, fontWeight: FontWeight.bold)),
        const SizedBox(width: Sizes.sm),
        Text(durationText, style: TextStyle(color: AppColors.gray)),
      ],
    );
  }
}