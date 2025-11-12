// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:focus_app/utils/popups/snackbar.dart';

/// xử lý `try-catch` để hiển thị thông báo khi `controller` bắt được lỗi 
Future<T?> HandleShowExeption<T> (BuildContext context, Future<T> Function() action) async {
  try {
    return await action();
  } catch (e) {
    if(context.mounted) {
      Snackbar.show(context, type: SnackbarEnum.error, message: e.toString());
    }
    return null;
  }
}