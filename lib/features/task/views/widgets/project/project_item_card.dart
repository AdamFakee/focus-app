import 'package:flutter/material.dart';
import 'package:focus_app/features/task/models/project_model.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/icons.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/popups/confirm_popup.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

enum _ProjectItemAction {
  edit(
    title: 'Edit',
    icon: Icons.edit,
    color: AppColors.darkGray
  ),
  delete(
    title: 'Delete',
    icon: Icons.delete,
    color: Colors.red,
  );

  final String title;
  final IconData icon;
  final Color color;

  const _ProjectItemAction({
    required this.title,
    required this.icon,
    required this.color,
  });
}

class ProjectItemCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onRefesh;
  final VoidCallback onDelete;

  const ProjectItemCard({
    super.key, 
    required this.project,
    required this.onRefesh,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.gripLines, color: Colors.grey),
      title: Row(
        spacing: Sizes.md,
        children: [
          FaIcon(AppIcons.project, color: project.color, size: 18),
          Text(project.name, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
      trailing: PopupMenuButton<_ProjectItemAction>( 
        color: AppColors.white,
        icon: const Icon(Icons.more_vert, color: AppColors.black,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.sm),
        ),
        onSelected: (_ProjectItemAction action) async {
          switch (action) {
            case _ProjectItemAction.edit:
              if(project.projectId != null) {
                // kiểm trả xem sau khi từ màn hình edit về thì có cần phải refresh lại data hay không? (Có cập nhật thì refresh)
                final isRefesh = await context.push<bool>(AppRouterNames.editProject(project.projectId!));
                if(isRefesh != null && isRefesh) {
                  onRefesh();
                }
              }
              break;
            case _ProjectItemAction.delete:
              final confirmed = await ConfirmPopup.show(context: context,);
              if(confirmed) {
                onDelete();
                onRefesh();
              }
              break;
          }
        },
        itemBuilder: (context) {
          return _ProjectItemAction.values.map((action) {
            return PopupMenuItem<_ProjectItemAction>(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.md / 2),
              value: action,
              child: Row(
                children: [
                  Icon(
                    action.icon,
                    size: 18,
                    color: action.color,
                  ),
                  const SizedBox(width: 8),
                  Text(action.title),
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}