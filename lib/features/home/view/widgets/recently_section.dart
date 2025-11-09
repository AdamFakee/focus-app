import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/cards/task_card.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/common/widgets/sections/section_title.dart';
import 'package:focus_app/utils/const/sizes.dart';

class RecentlySection extends StatelessWidget {
  const RecentlySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Recent Task", 
          buttonTitlte: "View All", 
          onPressed: () {}
        ),
        Column(
          spacing: Sizes.md,
          children: [
            TaskCard(
              mainIcon: Icons.mouse_outlined,
              title: "Designing Brand Logos",
              progressText: "4/6",
              durationText: "100/150 mins",
              trailing: IconContainer(
                icon: Icons.play_arrow,
                size: 40,
                backgroundColor: Colors.red.withOpacity(0.1),
                iconColor: Colors.red,
                onPressed: () {
            
                },
              ),
              onTap: () {
            
              },
            ),
            TaskCard(
              mainIcon: Icons.mouse_outlined,
              title: "Designing Brand Logos",
              progressText: "4/6",
              durationText: "100/150 mins",
              trailing: IconContainer(
                icon: Icons.play_arrow,
                size: 40,
                backgroundColor: Colors.red.withOpacity(0.1),
                iconColor: Colors.red,
                onPressed: () {
            
                },
              ),
              onTap: () {
            
              },
            ),
            TaskCard(
              mainIcon: Icons.mouse_outlined,
              title: "Designing Brand Logos",
              progressText: "4/6",
              durationText: "100/150 mins",
              trailing: IconContainer(
                icon: Icons.play_arrow,
                size: 40,
                backgroundColor: Colors.red.withOpacity(0.1),
                iconColor: Colors.red,
                onPressed: () {
            
                },
              ),
              onTap: () {
            
              },
            ),
            TaskCard(
              mainIcon: Icons.mouse_outlined,
              title: "Designing Brand Logos",
              progressText: "4/6",
              durationText: "100/150 mins",
              trailing: IconContainer(
                icon: Icons.play_arrow,
                size: 40,
                backgroundColor: Colors.red.withOpacity(0.1),
                iconColor: Colors.red,
                onPressed: () {
            
                },
              ),
              onTap: () {
            
              },
            ),
            TaskCard(
              mainIcon: Icons.mouse_outlined,
              title: "Designing Brand Logos",
              progressText: "4/6",
              durationText: "100/150 mins",
              trailing: IconContainer(
                icon: Icons.play_arrow,
                size: 40,
                backgroundColor: Colors.red.withOpacity(0.1),
                iconColor: Colors.red,
                onPressed: () {
            
                },
              ),
              onTap: () {
            
              },
            ),
          ],
        ),
      ],
    );
  }
}