import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/config/theme/app_color_scheme.dart';
import 'package:food_quest/core/config/theme/app_theme.dart';
import 'package:food_quest/core/local_storage/app_get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  /// Trạng thái light/dark hiện tại
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  final Rx<AppColorTheme> currentThemeIndex = AppColorTheme.theme1.obs;

  /// Scheme màu hiện tại (sẽ cập nhật mỗi khi thay đổi theme)
  Rx<AppColorScheme> appColorScheme =
      AppColorThemeScheme.getColorSchemeLight(AppColorTheme.theme1).obs;

  @override
  void onInit() {
    super.onInit();

    // Load theme mode từ bộ nhớ
    themeMode.value =
        AppGetStorage.getTheme() ? ThemeMode.dark : ThemeMode.light;
    // Load theme chính từ bộ nhớ
    currentThemeIndex.value = AppGetStorage.getPrimaryTheme(
      AppColorTheme.theme1,
    );

    // Khởi tạo appColorScheme và áp dụng theme
    Future.delayed(Duration.zero, () {
      applyCurrentTheme();
    });
  }

  /// Chuyển đổi giữa light/dark
  void toggleTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    AppGetStorage.saveTheme(themeMode.value == ThemeMode.dark);
    applyCurrentTheme();
  }

  /// Thay đổi màu chủ đạo của theme
  void changePrimaryTheme(AppColorTheme theme) {
    currentThemeIndex.value = theme;
    AppGetStorage.savePrimaryTheme(theme);
    applyCurrentTheme();
  }

  /// Áp dụng scheme màu và theme
  void applyCurrentTheme() {
    if (themeMode.value == ThemeMode.light) {
      appColorScheme.value = AppColorThemeScheme.getColorSchemeLight(
        currentThemeIndex.value,
      );
    } else if (themeMode.value == ThemeMode.dark) {
      appColorScheme.value = AppColorThemeScheme.getColorSchemeDark(
        currentThemeIndex.value,
      );
    }

    final ThemeData theme = themeMode.value == ThemeMode.dark
        ? AppTheme.dark(appColorScheme.value)
        : AppTheme.light(appColorScheme.value);

    Get.changeTheme(theme);
    Get.changeThemeMode(themeMode.value);
    update(["THEME_SITTING_ID"]);
    AppLogger.i(">>> UI UPDATE");
  }
}
