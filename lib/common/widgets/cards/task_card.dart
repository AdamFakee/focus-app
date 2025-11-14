import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/popups/confirm_popup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskCard extends StatefulWidget {
  final VoidCallback? onDelete;
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
    this.onDelete,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> with SingleTickerProviderStateMixin {
  bool isOpenRightSide = false;

  late final SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
    _slidableController.actionPaneType.addListener(_handleSlideStateChange);
  }

  void _handleSlideStateChange() {
    final actionPaneType = _slidableController.actionPaneType.value;

    // card ở yên, k bị kéo
    if (actionPaneType == ActionPaneType.none) {
      setState(() {
        isOpenRightSide = false;
      });
    }
    
    // đang kéo từ phải sang trái
    if (actionPaneType == ActionPaneType.end) {
      setState(() {
        isOpenRightSide = true;
      });
    }
  }

  @override
  void dispose() {
    _slidableController.actionPaneType.removeListener(_handleSlideStateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Xác định style cho text dựa trên trạng thái isCompleted
    final textDecoration = widget.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final decorationColor = widget.isCompleted ? AppColors.gray : null;

    // dịch chuyển widget
    final defaultOffset = Offset(0, 0);
    final rightSideOffset = Offset(30, 0);

    return Slidable(
      controller: _slidableController,
      endActionPane: 
        widget.onDelete != null
          ? ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) async {
                  final confirmed = await ConfirmPopup.show(
                    context: context,
                    title: 'This task will be delete forever.'
                  );

                  if(confirmed) {
                    widget.onDelete!();
                  }
                },
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Sizes.md),
                  bottomRight: Radius.circular(Sizes.md)
                ),
              ),
            ],
          ) 
        : null,
      child: Transform.translate(
        offset: isOpenRightSide ? rightSideOffset : defaultOffset,
        child: Opacity(
          opacity: widget.isCompleted ? 0.7 : 1.0,
          child: RoundedContainer(
            px: 0,
            py: 0,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(Sizes.md),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.md, vertical: Sizes.sm * 1.5),
                child: Row(
                  children: [
                    // 1. Icon chính bên trái
                    IconContainer(
                      icon: widget.mainIcon,
                      backgroundColor: widget.mainIconBackgroundColor ?? AppColors.primary,
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
                            widget.title,
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
                    if (widget.trailing != null) widget.trailing!,
                  ],
                ),
              ),
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
        Text(widget.progressText, style: metadataStyle),
        const SizedBox(width: Sizes.sm),
        Text('·', style: TextStyle(color: AppColors.gray, fontWeight: FontWeight.bold)),
        const SizedBox(width: Sizes.sm),
        Text(widget.durationText, style: metadataStyle),
      ],
    );
  }
}