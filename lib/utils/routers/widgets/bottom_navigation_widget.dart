import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (value) {
            _onChangeBottomTab(value, navigationShell, context);
          },
          destinations: [
            _navigationTab(icon: Icons.home, label: 'Home'),
            _navigationTab(icon: Iconsax.task, label: 'Task'),
          ],
          indicatorColor: AppColors.primary,
          animationDuration: Duration(milliseconds: 700),
          backgroundColor: AppColors.white,
          elevation: 8,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.transparent
        ),
      ),
    );
  }

  Widget _navigationTab({required IconData icon, required String label}) {
    return NavigationDestination(icon: Icon(icon), label: label);
  }

  void _onChangeBottomTab(int value, StatefulNavigationShell navigationShell, BuildContext context) {
    if(value == 1) {
      context.go(AppRouterNames.homeTab);
      return;
    }
    navigationShell.goBranch(
      value,
      initialLocation: value == navigationShell.currentIndex,
    );
  }
}
