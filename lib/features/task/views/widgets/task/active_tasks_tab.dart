import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/cards/task_card.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';


class ActiveTasksTab extends StatelessWidget {
  ActiveTasksTab({
    super.key,
  });

  final List<Map<String, dynamic>> activeTasks = [
    {
      'icon': Icons.desktop_mac_outlined,
      'color': Color(0xFFEF4444),
      'title': 'Design User Interface (UI)',
      'progress': '0/8',
      'duration': '0/200 mins',
    },
    {
      'icon': Icons.search,
      'color': Color(0xFF3B82F6),
      'title': 'Market Research & Analysis',
      'progress': '1/5',
      'duration': '25/125 mins',
    },
    {
      'icon': Icons.groups_outlined,
      'color': Color(0xFF22C55E),
      'title': 'Collaborate on a Project',
      'progress': '4/7',
      'duration': '100/175 mins',
    },
    {
      'icon': Icons.gesture,
      'color': Color(0xFFEF4444),
      'title': 'Create a Design Wireframe',
      'progress': '4/6',
      'duration': '100/150 mins',
    },
    {
      'icon': Icons.edit_note_outlined,
      'color': Color(0xFFF97316),
      'title': 'Write a Report & Proposal',
      'progress': '4/6',
      'duration': '100/150 mins',
    },
    {
      'icon': Icons.palette_outlined,
      'color': Color(0xFFA855F7),
      'title': 'Design App Icons & Assets',
      'progress': '6/8',
      'duration': '150/200 mins',
    },
    {
      'icon': Icons.lightbulb_outline,
      'color': Color(0xFF14B8A6),
      'title': 'Brainstorming Idea',
      'progress': '3/5',
      'duration': '75/125 mins',
    },
    {
      'icon': Icons.gesture,
      'color': Color(0xFFEF4444),
      'title': 'Create a Design Wireframe',
      'progress': '4/6',
      'duration': '100/150 mins',
    },
    {
      'icon': Icons.edit_note_outlined,
      'color': Color(0xFFF97316),
      'title': 'Write a Report & Proposal',
      'progress': '4/6',
      'duration': '100/150 mins',
    },
    {
      'icon': Icons.palette_outlined,
      'color': Color(0xFFA855F7),
      'title': 'Design App Icons & Assets',
      'progress': '6/8',
      'duration': '150/200 mins',
    },
    {
      'icon': Icons.lightbulb_outline,
      'color': Color(0xFF14B8A6),
      'title': 'Brainstorming Idea',
      'progress': '3/5',
      'duration': '75/125 mins',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: activeTasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: Sizes.spaceBtwItems),
      itemBuilder: (context, index) {
        final task = activeTasks[index];
        return TaskCard(
          mainIcon: task['icon'],
          mainIconBackgroundColor: task['color'],
          title: task['title'],
          progressText: task['progress'],
          durationText: task['duration'],
          trailing: IconContainer(
            icon: Icons.play_arrow,
            backgroundColor: AppColors.primaryLight,
          )
        );
      },
    );
  }
}