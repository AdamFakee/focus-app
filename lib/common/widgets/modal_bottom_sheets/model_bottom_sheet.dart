import 'package:flutter/material.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

/// hiển thị model bottom bằng [showBottomSheet] api của flutter
/// 
/// trường hợp sử dụng: khi vừa muốn hiển thị model bottom và vừa muốn tương tác với UI nằm dưới phần [barrier]
/// 
/// [shouldCloseOnMinExtent] : cho phép model bottom được đóng khi đại tới giới hạn tối thiểu hay k
class ModelBottomSheet {
  void show({
    required ScaffoldState state,
    required Widget child,
    bool isSnap = true,
    List<double> snapSizes = const [0.6, 0.8, 1],
    double minChildSize = 0.2,
    double? initialChildSize,
    bool shouldCloseOnMinExtent = true
  }) {
    state.showBottomSheet(
      enableDrag: false,
      (context) => DraggableScrollableSheet(
        // kéo xuống mà nhỏ quá => đóng
        shouldCloseOnMinExtent: shouldCloseOnMinExtent,

        /// cho snapSizes được hoạt động
        snap: isSnap,

        /// danh sách các nấc thang mà người dùng có thể kéo
        snapSizes: snapSizes,

        
        /// 50% height screen khi bật lên
        initialChildSize: initialChildSize ?? snapSizes.first,

        minChildSize: minChildSize,
        maxChildSize: snapSizes.last,

        /// chỉ chiếm phần diện tích của [DraggableScrollableSheet] chứ không chiếm luôn diện tích của [showMaterialModalBottomSheet]
        ///
        /// expand = true => phần [barrierColor] của [showMaterialModalBottomSheet] sẽ không hiển thị
        expand: false,

        builder: (context, scrollController) => Column(
          children: [
            /// --Indicator
            ///
            /// Việc dùng listview để dùng controllor
            ListView(
              /// Commen giải thích::::
              ///
              /// nghĩa là dùng scrollControler ở đây để khi scroll "child widget" sẽ điều khiển luôn cả widget "bottom sheet"
              /// vì đang sử dụng scrollController cấp cao nhất
              controller: scrollController,
              shrinkWrap: true,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 6,
                    margin: const EdgeInsets.only(
                      top: 4,
                      bottom: Sizes.defaultSpace,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ],
            ),

            /// --child
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (_) {
                  // khi widget này scroll sẽ không thông báo tới "parent widget"
                  return true;
                },
                child: SingleChildScrollView(
                  /// Commen giải thích::::
                  ///
                  /// nghĩa là không dùng scrollControler ở đây để khi scroll "child widget" sẽ không điều khiển luôn cả widget "bottom sheet"
                  /// vì đang sử dụng scrollController cấp cao nhất
                  ///
                  // controller: scrollController,
                  physics:
                      AlwaysScrollableScrollPhysics(), // cho phép "child widget" scroll
                  padding: EdgeInsets.only(
                    left: Sizes.md,
                    right: Sizes.md,
                    bottom: Sizes.md
                  ),
                  child: child
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
