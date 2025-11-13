import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/modal_bottom_sheets/modal_bottom_sheet_scrollable.dart';
import 'package:focus_app/features/task/blocs/icon_picker/icon_picker_bloc.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/data/icons/font_awesome_icon_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

Future<FontAwesomeIconModel?> showIconSelectionBottomSheet(BuildContext context) {
  final iconPickerBloc = context.read<IconPickerBloc>();

  return ModalBottomSheetScrollable().show<FontAwesomeIconModel>(
    context: context,
    initialChildSize: 0.6,
    snapSizes: [0.6, 0.8, 1],
    child: BlocProvider.value(
      value: iconPickerBloc,
      child: const _IconSelectionSheet(),
    ),
  );
}

class _IconSelectionSheet extends StatefulWidget {

  const _IconSelectionSheet();

  @override
  State<_IconSelectionSheet> createState() => _IconSelectionSheetState();
}

class _IconSelectionSheetState extends State<_IconSelectionSheet> {

  // query
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      EasyDebounce.debounce(
        'TASK_ICON_PCIKER_DIALOG_SEARCH',
        Duration(milliseconds: 500), 
        () => context.read<IconPickerBloc>().add(IconPickerSearch(_searchController.text))
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.md),
      child: Column(
        spacing: Sizes.md,
        children: [
          Text(
            'Add Icon',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search icon',
            ),
          ),
          Expanded(
            child: BlocBuilder<IconPickerBloc, IconPickerState> (
              builder: (context, state) {
                final bloc = context.read<IconPickerBloc>();
                return PagedGridView<int, FontAwesomeIconModel>(
                  shrinkWrap: true,
                  state: state, 
                  fetchNextPage: () => bloc.add(IconPickerFetchNext()), 
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder:(context, item, index) {
                      final icon = item;
                      return IconButton(
                        icon: FaIcon(icon.iconData, color: AppColors.darkGray,),
                        iconSize: Sizes.iconLg,
                        onPressed: () {
                          Navigator.of(context).pop(icon);
                        },
                      );
                    },
                  ), 
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: Sizes.md,
                    crossAxisSpacing: Sizes.md
                  )
                );
              },
            )
          )
        ],
      ),
    );
  }
}