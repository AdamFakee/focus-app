import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/appBars/app_bar.dart';
import 'package:focus_app/features/task/views/widgets/tag/list_tags.dart';
import 'package:focus_app/features/task/views/widgets/tag/tag_floating_button.dart';

class TagPage extends StatelessWidget {
  const TagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Mangages Tags",
        centerTitle: true,
        showBackButton: true,
      ),
      body: ListTags(),
      floatingActionButton: TagFloatingButton(),
    );
  }
}
