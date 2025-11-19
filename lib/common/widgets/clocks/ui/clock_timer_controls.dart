import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/clocks/ui/dialog/clock_session_dialog.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/common/widgets/modal_bottom_sheets/model_bottom_sheet_barrier.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/extensions/context_extensions.dart';
import 'package:focus_app/utils/popups/confirm_popup.dart';

/// Widget chứa các nút điều khiển: Reset, Play/Pause, Skip
class ClockTimerControls extends StatelessWidget {
  // Các hàm callback cho các nút bấm
  final VoidCallback onResetPressed;
  final VoidCallback onPlayPausePressed;
  final VoidCallback onSkipPressed;

  final bool isPaused;

  const ClockTimerControls({
    super.key,
    required this.isPaused,
    required this.onResetPressed,
    required this.onPlayPausePressed,
    required this.onSkipPressed,
  });

  @override
  Widget build(BuildContext ctx) {
    final isPortrait = ctx.isPortrait;

    return Row(
      spacing: Sizes.md, 
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Nút Reset
        IconContainer(
          icon: Icons.refresh,
          backgroundColor: AppColors.primaryLight,
          onPressed: () {
            if (isPortrait == false) {
              // Hiển thị ConfirmPopup khi màn hình ngang
              ConfirmPopup.show(
                context: ctx,
                title: "Reset Session",
                content: "Reset the current focus session?",
                textConfirm: "Yes, Reset",
              ).then((confirmed) {
                if (confirmed) {
                  onResetPressed();
                }
              });
            } else {
              // Hiển thị BottomSheet khi màn hình dọc
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
            }
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
            if (isPortrait == false) {
              // Hiển thị ConfirmPopup khi màn hình ngang
              ConfirmPopup.show(
                context: ctx,
                title: "Skip Session",
                content: "Skip the current focus session?",
                textConfirm: "Yes, Skip",
              ).then((confirmed) {
                if (confirmed) {
                  onSkipPressed();
                }
              });
            } else {
              // Hiển thị BottomSheet khi màn hình dọc
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
            }
          },
        )
      ],
    );
  }
}