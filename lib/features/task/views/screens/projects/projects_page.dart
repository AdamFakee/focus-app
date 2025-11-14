import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/features/task/views/widgets/project/list_projects.dart';
import 'package:focus_app/features/task/views/widgets/project/project_floading_button.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Mangages Projects",
        centerTitle: true,
        showBackButton: true,
      ),
      body: ListProjects(),
      floatingActionButton: ProjectFloadingButton()
    );
  }
}
