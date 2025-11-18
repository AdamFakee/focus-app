import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/home/blocs/promodor_time/promodor_timer_bloc.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/popups/confirm_popup.dart';

/// thời gian dạng "MM:SS" cho breakTime
String formatDurationForBreakTime(int secondsInBreakTime) {
  final minutes = secondsInBreakTime ~/ 60;
  final seconds = secondsInBreakTime % 60;

  return '${minutes.toString().padLeft(2, '0')}:'
         '${seconds.toString().padLeft(2, '0')}';
}


Future<void> showBreakTimePopup(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocProvider.value(
      value: context.read<PromodorTimerBloc>(),
      child: const BreakTimePopup(),
    ),
  );
}

class BreakTimePopup extends StatelessWidget {
  const BreakTimePopup({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    final confirm = await ConfirmPopup.show(
      context: context,
      title: "Dừng nghỉ giải lao?",
      content: "Bạn có chắc muốn kết thúc sớm thời gian nghỉ không?",
      textConfirm: "Kết thúc", 
    );

    if (confirm == true && context.mounted) {
      // Chỉ gửi event để BLoC xử lý
      context.read<PromodorTimerBloc>().add(
        PromodorTimerEventOnCancleBreakTime(),
      );
    }


    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: BlocListener<PromodorTimerBloc, PromodorTimerState>(
        // Chỉ lắng nghe khi trạng thái chuyển sang endBreakTime
        listenWhen: (previous, current) =>
            current.status == PromodorTimerStatus.endBreakTime,
        // Khi nhận được tín hiệu, tự đóng chính mình
        listener: (context, state) {
          Navigator.of(context).pop();
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
          ),
          child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.lg,
                  vertical: Sizes.spaceBtwSections,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.timer_outlined,
                        color: AppColors.white,
                        size: 60,
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),
                    Text(
                      "Làm tốt lắm!",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Sizes.sm),
                    Text(
                      "Đến giờ nghỉ rồi. Hãy để não bộ của bạn nghỉ ngơi và sạc lại năng lượng.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.darkGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Sizes.spaceBtwSections),
                    BlocSelector<PromodorTimerBloc, PromodorTimerState, int>(
                      selector: (state) {
                        return state.secondsInBreakTime;
                      },
                      builder: (context, state) {
                        return Text(
                          formatDurationForBreakTime(state), 
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                        );
                      },
                    ),
                    const SizedBox(height: Sizes.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => _onWillPop(context),
                        child: const Text("Bỏ qua nghỉ"),
                      ),
                    ),
                  ],
                ),
              )
        ),
      ),
    );
  }
}
