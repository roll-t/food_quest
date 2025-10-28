// =========================== //
//        WHEEL WIDGET         //
// =========================== //
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/ui/widgets/buttons/primary_button.dart';
import 'package:food_quest/core/ui/widgets/images/cache_image_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/main/home/feature/presentation/controller/scale_dialog_controller.dart';
import 'package:food_quest/main/home/feature/presentation/controller/wheel_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WheelSpinner extends GetView<WheelController> {
  const WheelSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 85.w,
          child: FortuneWheel(
            selected: controller.selected.stream,
            animateFirst: false,
            items: [
              for (final food in controller.foods)
                FortuneItem(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CacheImageWidget(imageUrl: food.image),
                      Container(color: Colors.black.withOpacity(0.7)),
                      // Tên món ăn
                      Center(
                        child: TextWidget(
                          text: food.name,
                          color: AppColors.white,
                          textStyle: AppTextStyle.semiBold18,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            indicators: const [
              FortuneIndicator(
                alignment: Alignment.topCenter,
                child: TriangleIndicator(color: Colors.red),
              ),
            ],
            onAnimationEnd: controller.onSpinEnd,
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => IgnorePointer(
            ignoring: controller.isSpinning.value,
            child: AnimatedScale(
              scale: controller.isPressed.value ? 0.9 : 1.0,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              child: Opacity(
                opacity: controller.isSpinning.value ? .6 : 1,
                child: PrimaryButton(
                  text: "Quay",
                  textSize: 30,
                  onPressed: controller.spinWheel,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =========================== //
//  UI HIỂN THỊ TRONG DIALOG  //
// =========================== //
class ScaleTransitionDialog extends GetView<ScaleDialogController> {
  final String result;
  const ScaleTransitionDialog({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: controller.scale,
      child: Center(
        child: Container(
          width: Get.width * .8,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events, size: 60, color: Colors.orange),
              const SizedBox(height: 12),
              const TextWidget(
                text: "🎉 Chúc mừng! 🎉",
                textAlign: TextAlign.center,
                colorFixed: true,
                textStyle: AppTextStyle.bold18,
              ),
              const SizedBox(height: 8),
              TextWidget(
                text: "Hôm nay ăn: $result",
                textAlign: TextAlign.center,
                colorFixed: true,
                textStyle: AppTextStyle.regular16,
              ),
              const SizedBox(height: 16),
              Row(
                spacing: 24,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: "Quay lại",
                      onPressed: controller.closeDialog,
                    ),
                  ),
                  Expanded(
                    child: PrimaryButton(
                      text: "Chỗ ăn",
                      onPressed: controller.closeDialog,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
