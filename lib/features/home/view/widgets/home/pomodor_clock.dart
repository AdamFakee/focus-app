import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/clocks/ui/clock_option_bar.dart';
import 'package:focus_app/common/widgets/clocks/ui/dialog/clock_strict_mode_dialog.dart';
import 'package:focus_app/common/widgets/clocks/ui/dialog/clock_timer_dialog.dart';
import 'package:focus_app/common/widgets/clocks/ui/clock_timer_ui.dart';
import 'package:focus_app/common/widgets/clocks/painter/counter_clock.dart';
import 'package:focus_app/common/widgets/clocks/painter/counter_clock_progress.dart';
import 'package:focus_app/common/widgets/clocks/ui/dialog/clock_white_noise_dialog.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/common/widgets/modal_bottom_sheets/model_bottom_sheet_barrier.dart';
import 'package:focus_app/features/home/blocs/promodor_time/promodor_timer_bloc.dart';
import 'package:focus_app/utils/const/sizes.dart';

class PomodorClock extends StatelessWidget {
  const PomodorClock({super.key});

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
                  size: const Size(
                    Sizes.clockBannerHeight,
                    Sizes.clockBannerHeight,
                  ),
                  painter: CounterClock(),
                ),
              ),

              // phần progress
              BlocSelector<PromodorTimerBloc, PromodorTimerState, double>(
                selector: (state) {
                  return state.completeProgress;
                },
                builder: (context, state) {
                  return CustomPaint(
                    size: const Size(
                      Sizes.clockBannerHeight,
                      Sizes.clockBannerHeight,
                    ),
                    painter: CounterClockProgress(progress: state),
                  );
                },
              ),

              BlocBuilder<PromodorTimerBloc, PromodorTimerState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Transform.translate(
                      offset: const Offset(0, 60),
                      child: ClockTimerUi(
                        time: state.formatDuration,
                        statusText: state.mode.name,
                        totalRounds: state.totalPomodoros,
                        currentRound: state.completedPomodoros,
                        isPaused: state.status.isPaused || state.status.isInitial,
                        onPlayPausePressed: () {
                          context.read<PromodorTimerBloc>().add(PromodorTimerEventOnStart());
                        },
                        onResetPressed: () {
                          context.read<PromodorTimerBloc>().add(PromodorTimerEventOnReset());
                        },
                        onSkipPressed: () {  },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        ClockOptionBar(
          onStrictModePressed: () {
            ModelBottomSheetBarrier().show(
              context: context,
              child: const ClockStrictModeDialog(),
              isSnap: false,
              initialChildSize: 0.55,
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
