import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

/// Extension mở rộng cho mọi kiểu Rx<T>
/// Extension dành riêng cho RxInt để hiển thị widget theo từng giá trị cụ thể.
///
/// Dễ dàng dùng để hiển thị nhiều widget tương ứng theo từng `index`.
///
/// Cách dùng:
/// ```dart
/// controller.currentTab.switchMapObx({
///   0: () => const HomePage(),
///   1: () => const ProfilePage(),
/// });
/// ```
extension RxSwitchMapWidget on RxInt {
  /// Dựa vào giá trị RxInt hiện tại, gọi builder tương ứng trong `map`.
  /// Nếu không tìm thấy, trả về `fallback` (mặc định là `SizedBox.shrink()`).
  Widget switchMapObx(Map<int, Widget Function()> map,
      {Widget fallback = const SizedBox.shrink()}) {
    return Obx(() => map[value]?.call() ?? fallback);
  }
}

/// Extension gọn hơn cho mọi Rx<T> giống như obxWidget
///
/// Cách dùng:
/// ```dart
/// controller.name.obx((value) => Text(value))
/// ```
extension RxAdvancedObxExtension<T> on Rx<T?> {
  Widget obx({
    required Widget Function(T value) onData,
    Widget Function()? onLoading,
    Widget Function()? onEmpty,
    bool Function(T value)? isEmptyCondition,
    Widget Function(String? error)? onError,
    bool Function(T value)? isLoadingCondition,
    RxBool? externalLoading,
  }) {
    return Obx(() {
      final data = value;

      // 👉 Nếu external loading đang bật
      if (externalLoading?.value == true) {
        return onLoading?.call() ?? const SizedBox.shrink();
      }
      
      // 👉 Nếu data null (sau first load) thì coi như không có dữ liệu
      if (data == null) {
        return onEmpty?.call() ?? const Center(child: Text("Không có dữ liệu"));
      }

      // 👉 Nếu data rỗng theo điều kiện
      if (isEmptyCondition != null && isEmptyCondition(data)) {
        return onEmpty?.call() ?? const Center(child: Text("Không có dữ liệu"));
      }

      // 👉 Nếu đang loading theo logic bên trong object
      if (isLoadingCondition != null && isLoadingCondition(data)) {
        return onLoading?.call() ?? const SizedBox.shrink();
      }

      // 👉 Hiển thị dữ liệu
      return onData(data);
    });
  }
}

/// Extension gọn hơn cho mọi Rx<T> giống như obxWidget
///
/// Cách dùng:
/// ```dart
/// controller.name.obx((value) => Text(value))
/// ```
extension RxObxWidgetExtension<T> on Rx<T> {
  /// Tạo widget reactive giống như [obxWidget], cú pháp ngắn gọn hơn.
  Widget obxWidget(Widget Function(T value) builder) {
    return Obx(() => builder(value));
  }
}
