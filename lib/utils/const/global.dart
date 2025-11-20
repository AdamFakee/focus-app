/// a class used for dynamic const value that useful in every where or specific feature. 
class Globals {
  /// Sqflite database name
  static const String dbName = "WE_CAN_DO_IT";

  /// limit item 
  static const limitInPagination = 20;

  /// smaller limit item 
  static const limitInSmallerPagination = 10;

  /// time for one poromodor
  /// 
  /// unit = `munite`
  static const timePerPoromodor = 1;

  /// time for one break time section
  /// 
  /// unit = `seconds`
  static const breakTimePerPoromodor = 10;

  /// chiều cao của thẻ lật khi dùng trong đếm giờ animation
  static const flipCounterTimerCardHeight = 175.0;

  /// khoảng cách giữa 2 nửa thẻ lật trong đếm giờ animation
  static const halfFlipCounterTimerCardSpacing = 3.0;

  /// asset path chứa âm thanh khi chạy kết thúc `pomodoro section` để đến breakTime
  static const assetPathInBreakTime = 'assets/audio/clock-alarm-8761.mp3';

  /// thời gian phát âm thanh thông báo breakTime
  static const notifyBreakTimeByAudioInSeconds = 5;
}