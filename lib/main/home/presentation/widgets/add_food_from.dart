import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/animations/scale_on_tap.dart';
import 'package:food_quest/core/ui/widgets/shimmer/shimmer_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/home/presentation/controller/add_food_form_controller.dart';
import 'package:food_quest/main/home/presentation/widgets/food_item.dart';
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
            height: 90.h,
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
      spacing: 12,
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
          ///---> [LOADING_CASE]
          if (controller.isLoadingSelectedFoods.value) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
              ),
              itemCount: 3,
              itemBuilder: (context, _) {
                return const ShimmerWidget();
              },
            );
          }

          ///---> [RENDER_CASE]
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
                    controller.onGoToAddFoodPage();
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
              return FoodItem(
                food: food,
                onRemove: () => controller.onRemoveFood(food),
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
            child: GetBuilder<AddFoodFormController>(
              builder: (controller) {
                return Obx(() {
                  if (controller.isLoadingRecentFoods.value) {
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: AppEdgeInsets.all6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.shimmerSingleColor,
                          ),
                        );
                      },
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: controller.recentFoods.length,
                    itemBuilder: (context, index) {
                      final FoodModel food = controller.recentFoods[index];
                      return ScaleOnTap(
                        onTap: () => controller.onSelectRecentFood(food),
                        child: Stack(
                          children: [
                            FoodItem(food: food),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                margin: AppEdgeInsets.all6,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  color: AppThemeColors.primary,
                                ),
                                height: 40,
                                child: const Center(
                                  child: TextWidget(
                                    text: "Chọn",
                                    color: AppColors.white,
                                    textStyle: AppTextStyle.semiBold16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
