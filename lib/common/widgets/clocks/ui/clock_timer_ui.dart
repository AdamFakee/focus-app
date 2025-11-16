import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/clocks/ui/dialog/clock_session_dialog.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/common/widgets/modal_bottom_sheets/model_bottom_sheet_barrier.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class ClockTimerUi extends StatelessWidget {
  const ClockTimerUi({
    super.key,
    this.time = "03:48",
    this.statusText = "Short break",
    this.totalRounds = 8,
    this.currentRound = 1,
    required this.isPaused,
    required this.onResetPressed,
    required this.onPlayPausePressed,
    required this.onSkipPressed,
  });

  // Dữ liệu để hiển thị trên UI
  final String time;
  final String statusText;
  final int totalRounds;
  final int currentRound;
  final bool isPaused;

  // Các hàm callback cho các nút bấm
  final VoidCallback onResetPressed;
  final VoidCallback onPlayPausePressed;
  final VoidCallback onSkipPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        top: Sizes.lg * 1.7
      ),
      child: Column(
        spacing: Sizes.md,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. PHẦN HIỂN THỊ THỜI GIAN
          _buildTimeDisplay(),
          
          // 2. PHẦN DOT INDICATOR VÀ TRẠNG THÁI
          _buildSessionIndicator(),
      
          // 3. PHẦN CÁC NÚT ĐIỀU KHIỂN
          _buildControls(context),
        ],
      ),
    );
  }

  /// Widget hiển thị icon nhỏ và đồng hồ đếm ngược
  Widget _buildTimeDisplay() {
    return Column(
      spacing: Sizes.md,
      children: [
        Icon(
          Icons.watch_later_outlined, // Icon ví dụ
          color: Colors.grey.shade400,
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  /// Widget hiển thị trạng thái hiện tại và các dot
  Widget _buildSessionIndicator() {
    return Column(
      spacing: Sizes.md,
      children: [
        // Các dot tròn
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalRounds, (index) {
            // Dot được tô màu nếu là vòng hiện tại hoặc các vòng đã qua
            bool isActive = index < currentRound;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? AppColors.red : Colors.grey.shade300,
              ),
            );
          }),
        ),
        // Text trạng thái
        Text(
          statusText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Widget chứa các nút điều khiển: Reset, Play/Pause, Skip
  Widget _buildControls(BuildContext ctx) {
    return Row(
      spacing: Sizes.md,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Nút Reset
        IconContainer(
          icon: Icons.refresh,
          backgroundColor: AppColors.primaryLight,
          onPressed: () {
            ModelBottomSheetBarrier().show(
              context: ctx,
              child: ClockSessionDialog(
                title: "Reset Session",
                desc: "Reset the current focus session?",
                onConfirmed: () {
                  onResetPressed();
                },
                confirmTitle: "Yes, Reset",
              ),
              isSnap: false,
              initialChildSize: 0.3,
              minChildSize: 0.3,
            );
          },
        ),
        
        // Nút Play/Pause lớn ở giữa
        InkWell(
          onTap: onPlayPausePressed,
          customBorder: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Icon(
              isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        
        // Nút Skip
        IconContainer(
          icon: Icons.skip_next,
          backgroundColor: AppColors.primaryLight,
          onPressed: () {
            ModelBottomSheetBarrier().show(
              context: ctx,
              child: ClockSessionDialog(
                title: "Skip Session",
                desc: "Skip the current focus session?",
                onConfirmed: () {
                  onSkipPressed();
                },
                confirmTitle: "Yes, Skip",
              ),
              isSnap: false,
              initialChildSize: 0.3,
              minChildSize: 0.3,
            );
          },
        )
      ],
    );
  }
}