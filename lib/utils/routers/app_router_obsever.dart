import 'package:flutter/material.dart';

/// Theo dõi sự thay đổi của [Route_Stack]
/// 
/// dùng để lưu log hay gì đó
class AppRouterObsever extends NavigatorObserver {
  //- Single Ton
  static final AppRouterObsever instance = AppRouterObsever._();
  AppRouterObsever._();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {

  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {

  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {

  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {

  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {

  }

  @override
  void didStopUserGesture() {

  }
}
