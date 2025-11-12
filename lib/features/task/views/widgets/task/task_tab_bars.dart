import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class TaskTabBars extends StatelessWidget {
  const TaskTabBars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(Sizes.md),
      ),
      child: TabBar(
        // ẩn divider mặc định
        dividerHeight: 0,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(Sizes.md),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        labelStyle: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.white),
        unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.black),
        
        tabs: const [
          Tab(text: 'Active'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }
}