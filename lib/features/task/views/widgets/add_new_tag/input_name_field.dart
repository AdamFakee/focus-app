import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/utils/const/icons.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputIconNameField extends StatefulWidget {
  final String sectionTitle;
  final IconData icon;
  final void Function(String text) onChangeText;

  const InputIconNameField({
    super.key, required this.sectionTitle, required this.onChangeText,
    this.icon = AppIcons.label
  });

  @override
  State<InputIconNameField> createState() => _InputIconNameFieldState();
}

class _InputIconNameFieldState extends State<InputIconNameField> {
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
          style: TextStyle(
            height: 1
          ),
          controller: controller,
          decoration: InputDecoration(
            hintText: 'e.g. Write proposal, Designing, etc.',
            prefixIcon: Center(child: FaIcon(widget.icon)),
            /// [FaIcon] bỏ [SizedBox] & [Centern] => nó không căn giữa => tạo ràng buộc 
            /// Vào source của FaIcon & Icon sẽ rõ hơn
            prefixIconConstraints: const BoxConstraints(
              maxWidth: Sizes.inputConstraintIconMaxWidth,
              minHeight: Sizes.inputConstraintIconMinHeight,
            ),
          ),
        ),
      ],
    );
  }
}
