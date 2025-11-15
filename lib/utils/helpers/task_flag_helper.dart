import 'package:focus_app/utils/storages/sql/tables/task/task_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Helper quản lý timestamp Task để thông báo khi có thay đổi trong Task Table
/// 
/// Dùng để biết cần fetch lại dữ liệu hay không.
class TaskFlagHelper {
  /// Key dùng lưu timestamp
  static const _taskTimestampKey = 'TIMESTAMP-${TaskTable.tableName}';

  /// Ghi lại thời điểm Task thay đổi (CRUD xong)
  /// 
  /// Gọi hàm này sau khi thêm, sửa, xóa Task
  static Future<void> markTaskChanged() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt(_taskTimestampKey, now);
  }

  /// Lấy thời điểm Task thay đổi lần cuối
  /// 
  /// Trả về null nếu chưa có
  static Future<DateTime?> getLastTaskChange() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_taskTimestampKey);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Kiểm tra dữ liệu có cần fetch không
  /// 
  /// So sánh thời điểm lấy data lần cuối (lastFetch) với hiện tại
  static Future<bool> shouldRefresh(DateTime? lastFetch) async {
    final lastChange = await getLastTaskChange();
    if (lastChange == null || lastFetch == null) return false; // chưa có dữ liệu thay đổi
    
    return lastChange.isAfter(lastFetch); // cần fetch nếu thay đổi sau lần fetch
  }
}
