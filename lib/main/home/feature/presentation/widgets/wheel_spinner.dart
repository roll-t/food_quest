import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_images.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/extension/export/extension.dart';
import 'package:food_quest/core/ui/animations/scale_on_tap.dart';
import 'package:food_quest/core/ui/widgets/buttons/primary_button.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/core/ui/widgets/images/asset_image_widget.dart';
import 'package:food_quest/core/ui/widgets/images/cache_image_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/home/feature/di/add_food_from_binding.dart';
import 'package:food_quest/main/home/feature/presentation/controller/wheel_controller.dart';
import 'package:food_quest/main/home/feature/presentation/widgets/add_food_from.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WheelSpinner extends StatelessWidget {
  const WheelSpinner({super.key});
  @override
  Widget build(BuildContext context) {
    const double wheelScale = 1.35;
    return GetBuilder<WheelController>(
      id: "WHEEL_ID",
      builder: (controller) {
        final List<FoodModel> listFood =
            controller.foods.isNotEmpty ? controller.foods : controller.foodsShimmer;
        return Column(
          children: [
            Transform.scale(
              scale: wheelScale,
              child: Stack(
                children: [
                  Container(
                    height: 100.w,
                    constraints: BoxConstraints(
                      maxHeight: 50.h,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: math.pi,
                          child: FortuneWheel(
                            selected: controller.selected.stream,
                            animateFirst: false,
                            indicators: const [
                              FortuneIndicator(child: SizedBox.shrink()),
                            ],
                            items: [
                              for (final food in listFood)
                                FortuneItem(
                                  child: Transform.rotate(
                                    angle: math.pi,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CacheImageWidget(imageUrl: food.image.orEmpty()),
                                        Container(
                                          color: AppColors.black.withOpacity(0.6),
                                        ),
                                        Center(
                                          child: TextWidget(
                                            text: food.name.orNA(),
                                            color: AppColors.white,
                                            textStyle: AppTextStyle.semiBold18,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                            onAnimationEnd: controller.onSpinEnd,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- Indicator (tay mèo) ---
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 5.w,
                    child: AppIcons.icHandCat.show(size: 50),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Transform.scale(
                      scale: 1.1,
                      child: const AssetImageWidget(
                        assetPath: AppImages.iBorderWheel,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: .2),
                                spreadRadius: 1,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: AppIcons.icCenterWheel.show(size: 50),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 90 * wheelScale),
            // ----- Nút quay -----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _BuildIconsFeature(
                  onTap: () {},
                  icon: AppIcons.icAskAi.show(size: 50),
                  label: "Hỏi trợ lý",
                ),
                _BuildIconsFeature(
                  icon: AppIcons.icAddFood.show(size: 50),
                  label: "Thêm món",
                  onTap: () {
                    DialogUtils.show(
                      binding: AddFoodFromBinding(),
                      const AddFoodFrom(),
                    );
                  },
                ),
                _BuildIconsFeature(
                  icon: AppIcons.icHistory.show(size: 50),
                  label: "Từng ăn",
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: AppEdgeInsets.h16,
              child: Column(
                children: [
                  Obx(
                    () => IgnorePointer(
                      ignoring: controller.isSpinning.value,
                      child: AnimatedScale(
                        scale: controller.isPressed.value ? 0.9 : 1.0,
                        duration: const Duration(milliseconds: 120),
                        curve: Curves.easeOut,
                        child: Opacity(
                          opacity: controller.isSpinning.value ? 0.6 : 1.0,
                          child: PrimaryButton(
                            text: "Quay",
                            textSize: 26,
                            isMaxParent: true,
                            onPressed: controller.spinWheel,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        );
      },
    );
  }
}

class _BuildIconsFeature extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback? onTap;

  const _BuildIconsFeature({
    required this.icon,
    this.onTap,
    this.label = "",
  });

  @override
  Widget build(BuildContext context) {
    return ScaleOnTap(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        spacing: 6,
        children: [
          icon,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.orange.withOpacity(.85),
            ),
            child: TextWidget(
              text: label,
              color: AppColors.white,
              textStyle: AppTextStyle.medium14,
            ),
          ),
        ],
      ),
    );
  }
}
