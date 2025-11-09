import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.buttonTitlte,
    this.onPressed,
  }) : assert(
        (buttonTitlte != null && onPressed != null) ||
        (buttonTitlte == null && onPressed == null),
        "Nếu dùng buttonTitle thì onPressed phải khác null, nếu không có buttonTitle thì onPressed phải null",
       );

  final String title;
  final String? buttonTitlte;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.apply(fontWeightDelta: 20, fontSizeDelta: 1.5),
        ),

        // button title
        if (buttonTitlte != null)
          Row(
            children: [
              TextButton(
                onPressed: onPressed,
                child: Text(
                  buttonTitlte!,
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: AppColors.primary,
                    fontWeightDelta: 5,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: Sizes.iconSm),
            ],
          ),
      ],
    );
  }
}
