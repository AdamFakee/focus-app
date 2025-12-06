// ignore_for_file: library_private_types_in_public_api

class _NotificationConfig {
  final String channelId;
  
  final String channelName;
  final String channelDescription;

  /// Group Key để gom nhóm thông báo trên Android
  final String groupKey;

  /// ID định danh của thông báo
  final int notificationId;

  const _NotificationConfig({
    required this.channelId,
    required this.channelName,
    this.channelDescription = '',
    required this.groupKey,
    required this.notificationId,
  });
}

class NotificationConstants {
  static const String _pomodoroGroup = 'com.yourapp.pomodoro.WORK_GROUP';

  /// 1. Cấu hình cho lúc ĐANG CHẠY (Im lặng, không rung để update mỗi giây)
  static const _NotificationConfig pomodoro = _NotificationConfig(
    channelId: 'Pomodoro',
    channelName: 'Pomodoro',
    channelDescription: 'Hiển thị thông tin của pomodoro khi chạy ở background',
    groupKey: _pomodoroGroup,
    notificationId: 1,
  );
}