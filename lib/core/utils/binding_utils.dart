import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ✅ Tiện ích quản lý Dependency Injection trong GetX.
/// Tự động kiểm tra, tránh duplicate put và hỗ trợ tag riêng cho từng instance.
/// Dùng được cho Controller, Repository, Service, ...
class BindUtils {
  /// 🔹 Đăng ký (hoặc lấy lại) controller ngay lập tức.
  /// - Nếu controller đã tồn tại => trả về controller cũ.
  /// - Nếu chưa => khởi tạo mới và put vào GetX.
  static T put<T extends GetxController>(
    T Function() builder, {
    String? tag,
    bool permanent = false,
  }) {
    final key = tag ?? T.toString();

    if (Get.isRegistered<T>(tag: key)) {
      _debugLog("⚠️ [BindUtils.put] '$key' đã tồn tại → trả về instance cũ");
      return Get.find<T>(tag: key);
    }

    final instance = Get.put<T>(
      builder(),
      tag: key,
      permanent: permanent,
    );

    _debugLog("✅ [BindUtils.put] Đã tạo mới '$key'");
    return instance;
  }

  /// 🔹 Tạo controller khi lần đầu được gọi (lazy init)
  /// - Nếu đã tồn tại → bỏ qua
  static void lazyPut<T extends GetxController>(
    T Function() builder, {
    String? tag,
    bool fenix = false,
  }) {
    final key = tag ?? T.toString();

    if (Get.isRegistered<T>(tag: key)) {
      _debugLog("⚠️ [BindUtils.lazyPut] '$key' đã tồn tại → bỏ qua");
      return;
    }

    Get.lazyPut<T>(
      builder,
      tag: key,
      fenix: fenix,
    );

    _debugLog("🕓 [BindUtils.lazyPut] Đã đăng ký lazy '$key'");
  }

  /// 🔹 Tạo controller với tag riêng (mỗi widget độc lập)
  static T putWithTag<T extends GetxController>(T Function() builder) {
    final tag = UniqueKey().toString();
    final instance = Get.put<T>(builder(), tag: tag);
    _debugLog("✨ [BindUtils.putWithTag] Tạo mới '${T.toString()}' với tag=$tag");
    return instance;
  }

  /// 🔹 Thay thế controller cũ (nếu có) bằng controller mới
  /// - Nếu controller đã tồn tại → delete rồi put lại
  /// - Nếu chưa → put bình thường
  static T putReplace<T extends GetxController>(
    T Function() builder, {
    String? tag,
    bool permanent = false,
    bool force = true,
  }) {
    final key = tag ?? T.toString();

    if (Get.isRegistered<T>(tag: key)) {
      _debugLog("♻️ [BindUtils.putReplace] '$key' đã tồn tại → xoá & thay thế");
      Get.delete<T>(tag: key, force: force);
    }

    final instance = Get.put<T>(
      builder(),
      tag: key,
      permanent: permanent,
    );

    _debugLog("✅ [BindUtils.putReplace] Đã tạo mới '$key'");
    return instance;
  }

  /// 🔹 Lấy controller nếu đã được đăng ký
  static T? find<T extends GetxController>({String? tag}) {
    final key = tag ?? T.toString();
    if (Get.isRegistered<T>(tag: key)) {
      _debugLog("🔍 [BindUtils.find] Tìm thấy '$key'");
      return Get.find<T>(tag: key);
    }
    _debugLog("❌ [BindUtils.find] '$key' chưa được đăng ký");
    return null;
  }

  /// 🔹 Xóa controller theo tag hoặc loại
  static void delete<T extends GetxController>({
    String? tag,
    bool force = false,
  }) {
    final key = tag ?? T.toString();
    if (Get.isRegistered<T>(tag: key)) {
      Get.delete<T>(tag: key, force: force);
      _debugLog("🗑 [BindUtils.delete] Đã xoá '$key'");
    } else {
      _debugLog("⚠️ [BindUtils.delete] '$key' không tồn tại → bỏ qua");
    }
  }

  /// 🔹 Kiểm tra controller đã tồn tại chưa
  static bool isRegistered<T extends GetxController>({String? tag}) {
    final key = tag ?? T.toString();
    final exists = Get.isRegistered<T>(tag: key);
    _debugLog("📦 [BindUtils.isRegistered] '$key' = $exists");
    return exists;
  }

  /// --- Log tiện ích (chỉ log khi ở debug mode) ---
  static void _debugLog(String msg) {
    assert(() {
      debugPrint(msg);
      return true;
    }());
  }
}
