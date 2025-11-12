import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/utils/const/sizes.dart';

class InputNameField extends StatefulWidget {
  final String sectionTitle;
  final void Function(String text) onChangeText;

  const InputNameField({super.key, required this.sectionTitle, required this.onChangeText});

  @override
  State<InputNameField> createState() => _InputNameFieldState();
}

class _InputNameFieldState extends State<InputNameField> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    controller.addListener(() {
      widget.onChangeText(controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.sm,
      children: [
        SectionLable(title: widget.sectionTitle),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'e.g. Write proposal, Designing, etc.',
          ),
        ),
      ],
    );
  }
}
