import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:go_router/go_router.dart';

/// class custom app bar that can reuse
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key, 
    this.title, 
    this.centerTitle = true,
    this.showBackButton = true, 
    this.actions, 
    this.padding = const EdgeInsetsGeometry.only(right: Sizes.defaultSpace)
  });

  final bool centerTitle;
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(right: Sizes.defaultSpace * 0.8, left: Sizes.md),
      child: AppBar(
        centerTitle: centerTitle,
        titleSpacing: 0,
        leading: showBackButton ? IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ) : null,
        automaticallyImplyLeading: false,
        title: title != null ? Text(title!, style: Theme.of(context).textTheme.headlineMedium!.apply(
          fontWeightDelta: 2,
          fontSizeDelta: 3
        )) : null,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, Sizes.appBarHeight);
}
