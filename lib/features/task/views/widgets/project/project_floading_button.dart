import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/buttons/custom_floating_button.dart';
import 'package:focus_app/features/task/blocs/lazy_loading/lazy_loading_bloc.dart';
import 'package:focus_app/features/task/models/project_model.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:go_router/go_router.dart';

class ProjectFloadingButton extends StatelessWidget {
  const ProjectFloadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFloatingButton(
      onPressed: () async {
        final isRefesh = await context.push<bool>(AppRouterNames.addNewProject);
        if(isRefesh != null && isRefesh && context.mounted) {
          context.read<LazyLoadingBloc<ProjectModel>>().add(LazyLoadingRefresh());
        }
      },
    );
  }
}