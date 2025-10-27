import 'package:food_quest/core/config/const/app_vectors.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/expand/expand_controller.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandSectionWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final ExpandController controller;

  const ExpandSectionWidget({
    super.key,
    required this.title,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: controller.toggle,
          child: Container(
            padding: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: AppThemeColors.primary,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Utils.iconSvg(
                  svgUrl: AppVectors.icList,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextWidget(
                    text: title,
                    size: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutralColor2,
                  ),
                ),
                Obx(() => Utils.iconSvg(
                      svgUrl: controller.isExpanded.value
                          ? AppVectors.icArrowUp
                          : AppVectors.icArrowDown,
                      size: 24,
                    ))
              ],
            ),
          ),
        ),
        Obx(
          () => AnimatedOpacity(
            opacity: controller.isExpanded.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child:
                controller.isExpanded.value ? child : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
