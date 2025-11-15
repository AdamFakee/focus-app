import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:go_router/go_router.dart';

class NotFoundItem extends StatelessWidget {
  final String title;

  final String? subtitle;

  final String buttonTitle;

  final VoidCallback? onPressed;

  final bool showButton;

  final IconData icon;

  const NotFoundItem({
    super.key,
    this.title = "Not Found",
    this.subtitle,
    this.icon = Icons.description_outlined,
    this.showButton = false,
    this.buttonTitle = "Go Back", 
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          spacing: Sizes.spaceBtwItems,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Icon(
              icon,
              size: 120,
              color: AppColors.gray
            ),

            // Tiêu đề
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.gray
              ),
              textAlign: TextAlign.center,
            ),

            // Phụ đề
            if (subtitle != null)
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.gray,
                    ),
                textAlign: TextAlign.center,
              ),
            
            // go-back button
            if(showButton)
              ElevatedButton(
                onPressed: () => onPressed != null ? onPressed!() : context.pop(),
                child: Text(buttonTitle),
              )
          ],
        ),
      ),
    );
  }
}