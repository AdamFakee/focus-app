import 'package:go_router/go_router.dart';

extension GorouterExtensions on GoRouter {
  /// kiểm tra xem có phải đang ở route hiện tại hay k?
  bool isCurrentRoute(String routePath) {
    final currentPath = routerDelegate.currentConfiguration.uri.path;

    return currentPath == routePath;
  }
}