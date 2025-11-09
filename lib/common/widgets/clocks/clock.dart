import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/clocks/clock_timer_ui.dart';
import 'package:focus_app/common/widgets/clocks/counter_clock.dart';
import 'package:focus_app/common/widgets/clocks/counter_clock_progress.dart';
import 'package:focus_app/utils/const/sizes.dart';

class Clock extends StatelessWidget {
  const Clock({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            offset: const Offset(0, 50), 
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
    );
  }
}