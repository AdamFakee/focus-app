import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/features/pomodoro/views/widgets/pomodoro/promodor_section.dart';
import 'package:focus_app/utils/const/sizes.dart';


class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        showBackButton: true,
        title: "Pomodoro",
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          spacing: Sizes.md,
          children: [
            PromodorSection(),
          ],
        ),
      ),
    );
  }
}
