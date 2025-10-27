import 'package:food_quest/core/config/feature_configs.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/main/setting/presentation/controller/setting_controller.dart';
import 'package:food_quest/main/setting/presentation/widget/select_language_widget.dart';
import 'package:food_quest/main/setting/presentation/widget/select_primary_theme_widget.dart';
import 'package:food_quest/main/setting/presentation/widget/setting_item_widget.dart';
import 'package:food_quest/core/config/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    super.key,
  });

  @override
  // Not set const to update the status
  // ignore: prefer_const_constructors
  Widget build(BuildContext context) => _BodyBuilder();
}

class _BodyBuilder extends GetView<SettingController> {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildSettingsList(),
    );
  }

  List<Widget> _buildSettingsList() {
    final items = <Widget>[];
    void addSetting(Widget widget) {
      if (items.isNotEmpty) items.add(const SizedBox(height: 12));
      items.add(widget);
    }

    if (FeatureConfigs.isThemeSwitchEnabled) {
      addSetting(
        GetBuilder<ThemeController>(builder: (themeController) {
          return SettingItemWidget(
            titleKey: "Ban đêm",
            trailing: Switch(
              activeColor:AppThemeColors.primary,
              value: themeController.themeMode.value == ThemeMode.dark,
              onChanged: (_) => themeController.toggleTheme(),
            ),
          );
        }),
      );
      addSetting(
        SettingItemWidget(
          titleKey: "Chủ đề",
          trailing: SelectPrimaryThemeWidget(width: 30.w),
        ),
      );
    }

    if (FeatureConfigs.isSwitchLanguageEnabled) {
      addSetting(
        SettingItemWidget(
          titleKey: "Ngôn ngữ",
          trailing: SelectLanguageWidget(
            controller: controller,
            width: 30.w,
          ),
        ),
      );
    }

    if (FeatureConfigs.isNotificationEnabled) {
      addSetting(
        SettingItemWidget(
          titleKey: 'notification',
          trailing: Switch(
            value: controller.isNotificationEnabled.value,
            onChanged: controller.toggleNotification,
          ),
        ),
      );
    }

    return items;
  }
}
