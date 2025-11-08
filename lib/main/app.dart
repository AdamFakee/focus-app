import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_app/utils/routers/app_routers.dart';
import 'package:focus_app/utils/themes/theme.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // đăng ký widget 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // cấu hình hiển thị statusBar và swipeBottomIndicator
    // mục đính: ẩn statusBar và chỉ hiển thị swipeBottomIndicator
    SystemChrome.setEnabledSystemUIMode(
      // tự cấu hình thủ công
      SystemUiMode.manual, 
      // nếu dùng kiểu thủ công thì cần thêm các option
      overlays: [
        // chỉ hiển thị swipeBottomIndicator
        SystemUiOverlay.bottom
      ],
    );
  }

  // trigger khi người dùng thay đổi themeMode của máy họ chứ không thông qua app. Tuy nhiên đây chỉ là thay đổi themMode của app một cách tạm thời chứ k lưu lại. Nếu thoát app vào lại vẫn sẽ dùng themeMode trong storage.
  // còn nếu chỉnh themeMode qua app thì sẽ được lưu vào storage để phục vụ cho các lần dùng app sau này
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    // ignore: unused_local_variable
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    
  }

  // huỷ đăng ký nếu như widget bị xoá
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      theme: AppThemes.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,

      // -- router
      routerConfig: AppRouters.routers,

    );
  }
}