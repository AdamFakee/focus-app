import 'package:flutter/material.dart';
import 'package:focus_app/features/task/models/tag_model.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/icons.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/popups/confirm_popup.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

enum _TagItemAction {
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

  const _TagItemAction({
    required this.title,
    required this.icon,
    required this.color,
  });
}

class TagItemCard extends StatelessWidget {
  final TagModel tag;
  final VoidCallback onRefesh;
  final VoidCallback onDelete;

  const TagItemCard({
    super.key, 
    required this.tag,
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
          FaIcon(AppIcons.label, color: tag.color, size: 18),
          Text(tag.tagName, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
      trailing: PopupMenuButton<_TagItemAction>( 
        color: AppColors.white,
        icon: const Icon(Icons.more_vert, color: AppColors.black,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.sm),
        ),
        onSelected: (_TagItemAction action) async {
          switch (action) {
            case _TagItemAction.edit:
              if(tag.tagId != null) {
                // kiểm trả xem sau khi từ màn hình edit về thì có cần phải refresh lại data hay không? (Có cập nhật thì refresh)
                final isRefesh = await context.push<bool>(AppRouterNames.editTag(tag.tagId!));
                if(isRefesh != null && isRefesh) {
                  onRefesh();
                }
              }
              break;
            case _TagItemAction.delete:
              final confirmed = await ConfirmPopup.show(context: context,);
              if(confirmed) {
                onDelete();
                onRefesh();
              }
              break;
          }
        },
        itemBuilder: (context) {
          return _TagItemAction.values.map((action) {
            return PopupMenuItem<_TagItemAction>(
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