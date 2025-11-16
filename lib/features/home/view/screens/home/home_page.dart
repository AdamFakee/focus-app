import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/features/home/view/widgets/home/promodor_section.dart';
import 'package:focus_app/features/home/view/widgets/home/recently_section.dart';
import 'package:focus_app/utils/const/sizes.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        showBackButton: false,
        title: "Let's stay focus",
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.notifications)
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          spacing: Sizes.md,
          children: [
            PromodorSection(),
      
            RecentlySection()
          ],
        ),
      ),
    );
  }
}
