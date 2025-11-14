import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/common/widgets/cards/task_card.dart';
import 'package:focus_app/common/widgets/clocks/clock.dart';
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
            TaskCard(
              mainIcon: Icons.refresh,
              title: "Create a Design Wireframe",
              progressText: "4/6",
              durationText: "100/150 mins",
              trailing: Icon(
                Icons.expand_more,
                color: Colors.grey.shade600,
              ),
              onTap: () {
      
              },
            ),
      
            Clock(),
      
      
            RecentlySection()
          ],
        ),
      ),
    );
  }
}
