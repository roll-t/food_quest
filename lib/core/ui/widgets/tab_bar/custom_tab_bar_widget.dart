import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/extension/core/empty_extensions.dart';
import 'package:food_quest/core/extension/core/rx_extensions.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/ui/widgets/tab_bar/custom_tab_bar_controller.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatelessWidget {
  final TabBarController controller;
  final ValueChanged<int>? onSelectedIndex;
  final String? label;
  final List<Widget>? tabBodies;

  const CustomTabBarWidget({
    super.key,
    required this.controller,
    this.onSelectedIndex,
    this.label,
    this.tabBodies,
  });

  @override
  Widget build(BuildContext context) {
    return controller.selectedIndex.obx(
      onData: (value) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextWidget(
                  text: label.orNA(),
                  textStyle: AppTextStyle.bold14,
                ),
              ),
              const SizedBox(height: 8.0)
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    width: 1,
                    color: AppThemeColors.primary,
                  ),
                ),
                child: Row(
                  children: List.generate(
                    controller.tabs.length,
                    (index) {
                      final isSelected =
                          controller.selectedIndex.value == index;

                      final TextStyle textStyle = TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? AppThemeColors.primary
                            : AppColors.grey,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      );

                      final BoxDecoration decorationActive = BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: isSelected
                            ? AppThemeColors.primary.withValues(alpha: .1)
                            : AppColors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppThemeColors.primary.withValues(alpha: .5)
                              : AppColors.white,
                          width: .5,
                        ),
                      );

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.onChangeTab(index);
                            onSelectedIndex?.call(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: decorationActive,
                            child: Text(
                              controller.tabs[index].title.orNA(),
                              textAlign: TextAlign.center,
                              style: textStyle,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Phần tabBodies đặt ngoài Container tab bar
            if ((tabBodies?.isNotEmpty ?? false)) ...[
              const SizedBox(height: 16),
              if (controller.selectedIndex.value <
                  (tabBodies?.length ?? 1)) ...[
                Expanded(
                  child: tabBodies?[controller.selectedIndex.value] ??
                      const SizedBox.shrink(),
                )
              ],
            ],
          ],
        ),
      ),
    );
  }
}
