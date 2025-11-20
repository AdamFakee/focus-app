import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/clocks/ui/clock_timer_controls.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/features/home/blocs/promodor_time/promodor_timer_bloc.dart';
import 'package:focus_app/features/home/view/widgets/home/flip_counter.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/extensions/context_extensions.dart';
import 'package:focus_app/utils/helpers/device_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class FullScreenClock {
  static show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<PromodorTimerBloc>(),
        child: BlocSelector<PromodorTimerBloc, PromodorTimerState, int>(
          selector: (state) {
            return state.secondsCompleteInCurrentSection;
          },
          builder: (context, state) {
            final minutes = state ~/ 60;
            final firstMinute = minutes ~/ 10;
            final secondMinute = minutes % 10;

            final seconds = state % 60;
            final firstSecond = seconds ~/ 10;
            final secondSecond = seconds % 10;
            return Material(
              child: Container(
                color: Color(0xFF191B1F),
                height: context.screenHeight(),
                width: context.screenWidht(),
                child: Stack(
                  children: [
                    // clock
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        spacing: Sizes.md,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlipCounter(currentValue: firstMinute),
                          FlipCounter(currentValue: secondMinute),

                          //- ":"
                          FlipCouterText(value: ":"),

                          FlipCounter(currentValue: firstSecond),
                          FlipCounter(currentValue: secondSecond),
                        ],
                      ),
                    ),

                    //- Exit
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconContainer(
                        icon: FontAwesomeIcons.x,
                        onPressed: () async {
                          context.pop();
                          await DeviceHelper.rotateToPotrait();
                        },
                        backgroundColor: Colors.transparent,
                        iconColor: AppColors.white,
                        iconSize: Sizes.iconMd,
                      ),
                    ),

                    //- Controls
                    BlocBuilder<PromodorTimerBloc, PromodorTimerState>(
                      builder: (context, state) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Transform.translate(
                            offset: Offset(0, -context.screenHeight() * 0.05),
                            child: ClockTimerControls(
                              isPaused:
                                  state.status.isPaused || state.status.isInitial,
                              onPlayPausePressed: () {
                                context.read<PromodorTimerBloc>().add(
                                  PromodorTimerEventOnStart(),
                                );
                              },
                              onResetPressed: () {
                                context.read<PromodorTimerBloc>().add(
                                  PromodorTimerEventOnReset(),
                                );
                              },
                              onSkipPressed: () {
                                context.read<PromodorTimerBloc>().add(
                                  PromodorTimerEventOnSkipSection(),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
