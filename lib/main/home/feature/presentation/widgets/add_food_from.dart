import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/animations/scale_on_tap.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/main/food/presentation/page/add_food_page.dart';
import 'package:food_quest/main/home/feature/presentation/controller/add_food_form_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddFoodFrom extends GetView<AddFoodFormController> {
  const AddFoodFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: controller.scaleAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 95.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const _BodyBuilder(),
          ),
        ),
      ),
    );
  }
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        _BuildListFoodSelected(),
        _BuildListFoodRecent(),
      ],
    );
  }
}

class _BuildListFoodSelected extends GetView<AddFoodFormController> {
  const _BuildListFoodSelected();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(
              text: "Món đã chọn",
              padding: EdgeInsets.only(left: 20),
              textStyle: AppTextStyle.medium18,
            ),
            AppIcons.icClose.show(
              align: Alignment.topRight,
              padding: AppEdgeInsets.all8,
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
        Obx(() {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: controller.listFoodSelected.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ScaleOnTap(
                  onTap: () {
                    Get.toNamed(const AddFoodPage().routeName);
                  },
                  child: Container(
                    margin: AppEdgeInsets.all8,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppThemeColors.primary.withValues(alpha: .5),
                    ),
                    child: AppIcons.icAdd.show(),
                  ),
                );
              }
              final food = controller.listFoodSelected[index - 1];

              return Stack(
                children: [
                  Container(
                    margin: AppEdgeInsets.all8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue.shade100,
                      image: DecorationImage(
                        image: NetworkImage(food.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: AppEdgeInsets.all12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.white.withValues(alpha: .85),
                        ),
                        child: TextWidget(
                          text: food.name,
                          textStyle: AppTextStyle.medium14,
                          colorFixed: true,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => controller.removeFood(food),
                      child: AppIcons.icCloseV2.show(),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ],
    );
  }
}

class _BuildListFoodRecent extends StatelessWidget {
  const _BuildListFoodRecent();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        spacing: 8,
        children: [
          const TextWidget(
            text: "Món ăn gần đây",
            textStyle: AppTextStyle.medium18,
            padding: EdgeInsets.only(left: 20),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 30,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
