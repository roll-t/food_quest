import 'package:flutter/material.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/features/setting/presentation/controller/setting_controller.dart';
import 'package:get/get.dart';

class SelectLanguageWidget extends StatelessWidget {
  const SelectLanguageWidget({
    super.key,
    required this.controller,
    this.width,
  });

  final SettingController controller;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButton<String>(
        value: controller.selectedLanguage.value,
        items: controller.languages
            .map(
              (lang) => DropdownMenuItem(
                value: lang,
                child: TextWidget(
                  text: lang.tr,
                  color: AppThemeColors.text,
                ),
              ),
            )
            .toList(),
        onChanged: (value) => controller.setLanguage(value ?? ""),
        dropdownColor: AppThemeColors.background100,
        isExpanded: width != null,
      ),
    );
  }
}
