import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:go_router/go_router.dart';

class TaskFloatingButton extends StatefulWidget {
  const TaskFloatingButton({
    super.key,
  });

  @override
  State<TaskFloatingButton> createState() => _TaskFloatingButtonState();
}

class _TaskFloatingButtonState extends State<TaskFloatingButton> with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;

  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0, end: 0.125).animate(controller);
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });

    if (_isMenuOpen) {
      controller.forward(); 
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Menu chỉ hiển thị khi _isMenuOpen là true
        if (_isMenuOpen) _buildPopupMenu(context),

        // Thêm một khoảng trống nhỏ giữa menu và nút
        if (_isMenuOpen) const SizedBox(height: Sizes.md),

        // FloatingActionButton chính
        FloatingActionButton(
          onPressed: _toggleMenu,
          backgroundColor: AppColors.primary,
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return RotationTransition(
                turns: animation,
                child: child,
              );
            },
            child: Icon(
              _isMenuOpen ? Icons.close : Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  /// Widget con để xây dựng menu bật lên
  Widget _buildPopupMenu(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: Sizes.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.md),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(
            context,
            icon: Icons.task_alt_outlined,
            title: 'Task',
            onTap: () {
              context.push(AppRouterNames.addNewTask);
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.work_outline,
            title: 'Project',
            onTap: () {
              context.push(AppRouterNames.addNewProject);
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.sell_outlined,
            title: 'Tag',
            onTap: () {
              context.push(AppRouterNames.addNewTag);
            },
          ),
        ],
      ),
    );
  }

  /// Widget con để xây dựng từng mục trong menu
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        // Đóng menu trước khi thực hiện hành động
        _toggleMenu();
        // Gọi hàm callback
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.grey[800]),
            const SizedBox(width: 12),
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}