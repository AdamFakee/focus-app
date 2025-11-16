import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/common/widgets/cards/task_card.dart';
import 'package:focus_app/common/widgets/containers/icon_container.dart';
import 'package:focus_app/common/widgets/feedbacks/not_found_item.dart';
import 'package:focus_app/common/widgets/sections/section_title.dart';
import 'package:focus_app/features/home/blocs/promodor_task/promodor_task_bloc.dart';
import 'package:focus_app/features/home/blocs/recently_tasks/recently_tasks_bloc.dart';
import 'package:focus_app/features/task/blocs/task_action/task_action_bloc.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/extensions/context_extensions.dart';
import 'package:focus_app/utils/extensions/gorouter_extensions.dart';
import 'package:focus_app/utils/helpers/task_flag_helper.dart';
import 'package:focus_app/utils/routers/app_router_names.dart';
import 'package:go_router/go_router.dart';

class RecentlySection extends StatefulWidget{
  const RecentlySection({super.key});

  @override
  State<RecentlySection> createState() => _RecentlySectionState();
}

class _RecentlySectionState extends State<RecentlySection> with RouteAware {
  /// thời điểm [CRUD] mới nhất của [Task_Table] khi [RecentlySection] được khởi tạo 
  DateTime? _currentTaskTableCreateAt;

  late final GoRouter _router;

  // dùng để làm mốc so sánh khi thay đổi route
  /// ví dụ: hiện tại là màn hình A, [_isScreenVisible] = [true]
  ///       khi sang màn hình B => [_isScreenVisible] = [true]
  ///       từ đó về sau, nếu sang các màn hình khác A => [_isScreenVisible] giữ nguyên
  ///       nếu quay lại màn hình A => gọi hàm logic => gán lại [_isScreenVisible] 
  bool _isScreenVisible = true; 
  

  @override
  void initState() {
    super.initState();

    // Current GoRouter instance
    _router = GoRouter.of(context);

    // lắng nghe sự thay đổi của route
    // từ màn A -> B -> C -> B -> D -> A đều chạy hàm đã đăng ký
    _router.routerDelegate.addListener(_handleRouteChange);
    
    _loadInitialData();
  }

  @override
  void dispose() {
    _router.routerDelegate.removeListener(_handleRouteChange);
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    _currentTaskTableCreateAt = await TaskFlagHelper.getLastTaskChange();
  }

  void _handleRouteChange() async {
    final bool isVisible = _router.isCurrentRoute(AppRouterNames.homeTab);
    
    if (_isScreenVisible != isVisible) {
      _isScreenVisible = isVisible;

      final shouldFetch = await TaskFlagHelper.shouldRefresh(_currentTaskTableCreateAt);
      if (_isScreenVisible && shouldFetch && context.mounted) {
        context.read<RecentlyTasksBloc>().add(RecentlyTasksOnFetched());
      } 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTitle(
          title: "Recent Task",
          buttonTitlte: "View All",
          onPressed: () {},
        ),
        BlocBuilder<RecentlyTasksBloc, RecentlyTasksState>(
          buildWhen: (previous, current) {
            return previous.tasks != current.tasks;
          },
          builder: (context, state) {
            return Column(
              children: [
                //- Not Found Widget
                if(state.tasks.isEmpty) 
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: context.screenHeight() * 0.6
                    ),
                    child: NotFoundItem(
                      showButton: true,
                      buttonTitle: 'Create New Task',
                      onPressed: () async {
                        final refresh = await context.push<bool>(AppRouterNames.addNewTask);
                        if(refresh == true && context.mounted) {
                          context.read<RecentlyTasksBloc>().add(RecentlyTasksOnFetched());
                        }
                      },
                    ),
                  ),
            
                //- list task
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder:(context, index) {
                    final task = state.tasks[index];
                    return TaskCard(
                      isCompleted: false,
                      mainIcon: task.icon,
                      mainIconBackgroundColor: task.color,
                      title: task.taskName,
                      progressText: task.progressPomodoros,
                      durationText: task.timeProgress,
                      trailing: IconContainer(
                        icon: Icons.play_arrow,
                        backgroundColor: AppColors.lightGray,

                        // chọn task để chạy
                        onPressed: () {
                          context.read<PromodorTaskBloc>().add(PromodorTaskEventOnSelectTask(task: task));
                        },
                      ),
                      onDelete: task.taskId != null ? () {
                        // delete
                        context.read<TaskActionBloc>().add(TaskActionOnDelete(taskId: task.taskId!));

                        // refresh data
                        context.read<RecentlyTasksBloc>().add(RecentlyTasksDeleteItem(task.taskId!));
                      } : null,
                    );
                  }, 
                  separatorBuilder:(context, index) {
                    return const SizedBox(height: Sizes.md,);
                  }, 
                  itemCount: state.tasks.length
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
