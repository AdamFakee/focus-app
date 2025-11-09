import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/clocks/ui/clock_option_bar.dart';
import 'package:focus_app/common/widgets/clocks/ui/clock_strict_mode_dialog.dart';
import 'package:focus_app/common/widgets/clocks/ui/dialog/clock_timer_dialog.dart';
import 'package:focus_app/common/widgets/clocks/ui/clock_timer_ui.dart';
import 'package:focus_app/common/widgets/clocks/painter/counter_clock.dart';
import 'package:focus_app/common/widgets/clocks/painter/counter_clock_progress.dart';
import 'package:focus_app/common/widgets/clocks/ui/dialog/clock_white_noise_dialog.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/common/widgets/modal_bottom_sheets/model_bottom_sheet_barrier.dart';
import 'package:focus_app/utils/const/sizes.dart';

class Clock extends StatelessWidget {
  const Clock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Sizes.md,
      children: [
        RoundedContainer(
          height: Sizes.clockBannerHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // phần nền 
              RepaintBoundary(
                child: CustomPaint(
                  size: const Size(Sizes.clockBannerHeight, Sizes.clockBannerHeight),
                  painter: CounterClock(),
                ),
              ),

              // phần progress 
              CustomPaint(
                size: const Size(Sizes.clockBannerHeight, Sizes.clockBannerHeight),
                painter: CounterClockProgress(progress: 0.6),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: const Offset(0, 60), 
                  child: ClockTimerUi(
                    time: "00:00",
                    statusText: "Short break",
                    totalRounds: 8,
                    currentRound: 2,
                    isPaused: false,
                  ),
                ),
              ),
            ],
          )
        ),
        ClockOptionBar(
          onStrictModePressed: () {
            ModelBottomSheetBarrier().show(
              context: context,
              child: const ClockStrictModeDialog(),
              isSnap: false,
              initialChildSize: 0.55, // Tăng chiều cao để chứa hết nội dung
              minChildSize: 0.4,
            );
          },
          onTimerModePressed: () {
            ModelBottomSheetBarrier().show(
              context: context,
              child: const ClockTimerDialog(),
              isSnap: false,
              initialChildSize: 0.4,
              minChildSize: 0.4,
            );
          },
          onWhiteNoisePressed: () {
            ModelBottomSheetBarrier().show(
              context: context,
              child: const ClockWhiteNoiseDialog(),
              isSnap: false,
              initialChildSize: 0.5,
              minChildSize: 0.5,
            );
          },
        ),
      ],
    );
  }
}