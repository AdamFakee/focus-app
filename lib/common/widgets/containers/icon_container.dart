import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/containers/rounded_container.dart';
import 'package:focus_app/utils/const/sizes.dart'; 

/// Một container tròn, có bóng mờ, được thiết kế chuyên để chứa một Icon.
/// Widget này có thể được nhấn vào nếu cung cấp hàm `onPressed`.
class IconContainer extends StatelessWidget {
  /// Icon để hiển thị, ví dụ: `Icons.add`
  final IconData icon;

  /// Kích thước của container (chiều rộng và chiều cao bằng nhau).
  /// Mặc định là 56.
  final double size;

  /// Kích thước của icon bên trong.
  /// Nếu không được cung cấp, nó sẽ tự tính toán dựa trên `size` (size * 0.6).
  final double? iconSize;

  /// Màu của icon.
  final Color? iconColor;

  /// Màu nền của container.
  final Color? backgroundColor;

  /// Hàm callback sẽ được gọi khi người dùng nhấn vào.
  /// Nếu `null`, widget sẽ không phản hồi khi nhấn.
  final VoidCallback? onPressed;

  const IconContainer({
    super.key,
    required this.icon,
    this.size = Sizes.iconLg * 1.3,
    this.iconSize,
    this.iconColor,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Bọc trong GestureDetector hoặc InkWell để có thể nhấn vào
    return InkWell(
      onTap: onPressed,
      // Đảm bảo hiệu ứng ripple (khi nhấn) cũng là hình tròn
      borderRadius: BorderRadius.circular(size / 2),
      child: RoundedContainer(
        width: size,
        height: size,
        // Bán kính bằng một nửa kích thước để tạo thành hình tròn hoàn hảo
        radius: size / 2,
        // Không cần padding bên trong vì ta sẽ căn giữa Icon
        px: 0,
        py: 0,
        bg: backgroundColor,
        child: Center(
          child: Icon(
            icon,
            size: iconSize ?? size * 0.6, // Tự tính size icon nếu không có
            color: iconColor,
          ),
        ),
      ),
    );
  }
}