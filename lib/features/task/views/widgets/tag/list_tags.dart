import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/features/task/blocs/delete_tag/delete_tag_bloc.dart';
import 'package:focus_app/features/task/blocs/lazy_loading/lazy_loading_bloc.dart';
import 'package:focus_app/features/task/models/tag_model.dart';
import 'package:focus_app/features/task/views/widgets/tag/tag_item_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListTags extends StatelessWidget {
  const ListTags({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LazyLoadingBloc<TagModel>, LazyLoadingState<TagModel>>(
      builder: (context, state) {
        final bloc = context.read<LazyLoadingBloc<TagModel>>();
        return PagedListView<int, TagModel>.separated(
          state: state,
          fetchNextPage: () { 
            bloc.add(LazyLoadingFetchNext());
          }, 
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder:(context, tag, index) {
              return TagItemCard(
                tag: tag,
                onRefesh: () {
                  context.read<LazyLoadingBloc<TagModel>>().add(LazyLoadingRefresh());
                },
                onDelete: () {
                  if(tag.tagId != null) {
                    context.read<DeleteTagBloc>().add(DeleteTagSubmitted(tag.tagId!));
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
