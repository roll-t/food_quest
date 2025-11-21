import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/config/theme/app_color_scheme.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/config/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPrimaryThemeWidget extends GetView<ThemeController> {
  final double? width;
  const SelectPrimaryThemeWidget({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButton<int>(
        value: controller.currentThemeIndex.value.index,
        items: AppColorTheme.values.map((theme) {
          return DropdownMenuItem(
            value: theme.index,
            child: TextWidget(
              text: "Chủ đề  ${theme.index + 1}",
              transform: TextTransformType.capitalizeWords,
              color: AppThemeColors.text,
            ),
          );
        }).toList(),
        onChanged: (selectedIndex) {
          if (selectedIndex != null) {
            final selectedTheme = AppColorTheme.values[selectedIndex];
            controller.changePrimaryTheme(selectedTheme);
          }
        },
        hint: TextWidget(
          text: "Chọn chủ đề",
          color: AppThemeColors.text,
        ),
        isExpanded: width != null,
      ),
    );
  }
}
