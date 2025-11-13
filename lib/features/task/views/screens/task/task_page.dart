import 'package:flutter/material.dart';
import 'package:focus_app/features/task/views/widgets/task/active_tasks_tab.dart';
import 'package:focus_app/features/task/views/widgets/task/completed_tasks_tab.dart';
import 'package:focus_app/features/task/views/widgets/task/task_app_bar.dart';
import 'package:focus_app/features/task/views/widgets/task/task_floating_button.dart';
import 'package:focus_app/features/task/views/widgets/task/task_tab_bars.dart';
import 'package:focus_app/utils/const/sizes.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TaskAppBar(),
        body: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
            child: Column(
              children: [
                // Custom Tab Bar
                TaskTabBars(),
                const SizedBox(height: Sizes.spaceBtwSections),
                // Tab Content
                Expanded(
                  child: TabBarView(
                    children: [
                      // Active Tasks List
                      ActiveTasksTab(),
                      // Completed Tasks (Placeholder)
                      CompletedTasksTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: TaskFloatingButton(),
      );
  }
}