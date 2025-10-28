import 'package:flutter/material.dart';
// ignore: file_names
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/const/app_vectors.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:get/get.dart';

import 'sort_controller.dart';

class SortToggleWidget extends StatelessWidget {
  final VoidCallback? onSort;
  final SortController controller;
  const SortToggleWidget({
    super.key,
    required this.controller,
    this.onSort,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSort ?? controller.toggleSort,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: AppThemeColors.background100,
          border: Border.all(
            width: .5,
            color: AppColors.text400,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => TextWidget(
                text: controller.label,
                color: AppThemeColors.text100,
                textStyle: AppTextStyle.semiBold14,
              ),
            ),
            const SizedBox(width: 10),
            AppVectors.icFilter.show(
              color: AppThemeColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
