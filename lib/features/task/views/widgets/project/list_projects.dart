import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/feedbacks/not_found_item.dart';
import 'package:focus_app/features/task/blocs/delete_project/delete_project_bloc.dart';
import 'package:focus_app/features/task/blocs/lazy_loading/lazy_loading_bloc.dart';
import 'package:focus_app/features/task/models/project_model.dart';
import 'package:focus_app/features/task/views/widgets/project/project_item_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListProjects extends StatelessWidget {
  const ListProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LazyLoadingBloc<ProjectModel>, LazyLoadingState<ProjectModel>>(
      builder: (context, state) {
        final bloc = context.read<LazyLoadingBloc<ProjectModel>>();
        return PagedListView<int, ProjectModel>.separated(
          state: state,
          fetchNextPage: () { 
            bloc.add(LazyLoadingFetchNext());
          }, 
          builderDelegate: PagedChildBuilderDelegate(
            noItemsFoundIndicatorBuilder: (context) {
              return NotFoundItem(
                icon: FontAwesomeIcons.briefcase,
              );
            },
            itemBuilder:(context, project, index) {
              return ProjectItemCard(
                project: project,
                onRefesh: () {
                  context.read<LazyLoadingBloc<ProjectModel>>().add(LazyLoadingRefresh());
                },
                onDelete: () {
                  if(project.projectId != null) {
                    context.read<DeleteProjectBloc>().add(DeleteProjectSubmitted(project.projectId!));
                  }
                },
              );
            },
          ), 
          separatorBuilder: (BuildContext context, int index) { 
            return Divider();
          },
        );
      },
    );
  }
}
