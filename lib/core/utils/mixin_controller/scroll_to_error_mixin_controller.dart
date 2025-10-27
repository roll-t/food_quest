import 'package:flutter/material.dart';

/// Mixin tiện ích giúp tự động scroll đến các trường nhập liệu (TextField, TextArea,...) khi xảy ra lỗi.
///
/// ✅ Cách sử dụng:
/// 1. Sử dụng `with ScrollToErrorMixinController` trong controller.
/// 2. Gọi `registerKeys(['fieldName1', 'fieldName2'])` để khởi tạo các GlobalKey.
/// 3. Dùng `getKey('fieldName')` để gán key cho widget.
/// 4. Gọi `scrollToField('fieldName')` để cuộn tới widget khi cần.
///
/// 📌 Lưu ý: Tên key phải thống nhất khi đăng ký và sử dụng.

mixin ScrollToErrorMixinController {
  /// ScrollController có thể sử dụng khi bạn cần gán vào `ListView`, `SingleChildScrollView`, v.v.
  final ScrollController scrollController = ScrollController();

  /// Map chứa danh sách GlobalKey được quản lý theo tên (string)
  final Map<String, GlobalKey> fieldKeys = {};

  /// Đăng ký danh sách tên key tương ứng với các trường nhập liệu
  ///
  /// Ví dụ:
  /// ```dart
  /// registerKeys(['fullName', 'email', 'phone']);
  /// ```
  void registerKeys(List<String> keys) {
    for (final key in keys) {
      fieldKeys[key] = GlobalKey();
    }
  }

  /// Trả về GlobalKey tương ứng với tên đã đăng ký
  ///
  /// Ví dụ:
  /// ```dart
  /// key: getKey('email')
  /// ```
  ///
  /// Nếu key chưa được đăng ký, sẽ ném ra exception.
  GlobalKey getKey(String name) {
    final key = fieldKeys[name];
    if (key == null) {
      throw Exception(
          "GlobalKey '$name' chưa được đăng ký. Hãy gọi registerKeys trước.");
    }
    return key;
  }

  /// Tự động scroll đến field theo tên đã đăng ký
  ///
  /// Ví dụ:
  /// ```dart
  /// scrollToField('phone');
  /// ```
  void scrollToField(String name,
      {Duration duration = const Duration(milliseconds: 300)}) {
    final context = getKey(name).currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: duration,
        curve: Curves.easeInOut,
      );
    }
  }

  /// Scroll đến một field theo GlobalKey nếu bạn không sử dụng tên
  ///
  /// Ví dụ:
  /// ```dart
  /// scrollToKey(myGlobalKey);
  /// ```
  void scrollToKey(GlobalKey key,
      {Duration duration = const Duration(milliseconds: 300)}) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: duration,
        curve: Curves.easeInOut,
      );
    }
  }
}
