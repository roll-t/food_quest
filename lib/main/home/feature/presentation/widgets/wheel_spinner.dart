// =========================== //
//        WHEEL WIDGET         //
// =========================== //
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_images.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/ui/animations/app_animation_controller.dart';
import 'package:food_quest/core/ui/widgets/buttons/primary_button.dart';
import 'package:food_quest/core/ui/widgets/images/asset_image_widget.dart';
import 'package:food_quest/core/ui/widgets/images/cache_image_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/binding_utils.dart';
import 'package:food_quest/main/home/feature/presentation/controller/scale_dialog_controller.dart';
import 'package:food_quest/main/home/feature/presentation/controller/wheel_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WheelSpinner extends GetView<WheelController> {
  const WheelSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    const double wheelScale = 1.35;
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
                          for (final food in controller.foods)
                            FortuneItem(
                              child: Transform.rotate(
                                angle: math.pi,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CacheImageWidget(imageUrl: food.image),
                                    Container(
                                      color: AppColors.black.withOpacity(0.6),
                                    ),
                                    Center(
                                      child: TextWidget(
                                        text: food.name,
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
                bottom: 10,
                child: AppIcons.icHandCat.show(size: 50),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: Transform.scale(
                  scale: 1.15,
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
    final controller = BindUtils.putWithTag(() => ScaleAnimationController());
    return GestureDetector(
      onTap: () async {
        await controller.playTapScale();
        onTap?.call();
      },
      child: AnimatedBuilder(
        animation: controller.scaleCtrl,
        builder: (context, child) {
          return Transform.scale(
            scale: controller.scaleCtrl.value,
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
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WheelDividerPainter extends CustomPainter {
  final int sectionCount;
  final Color color;
  final double strokeWidth;

  WheelDividerPainter({
    required this.sectionCount,
    this.color = Colors.white,
    this.strokeWidth = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final angleStep = 2 * math.pi / sectionCount;

    for (int i = 0; i < sectionCount; i++) {
      final angle = i * angleStep;
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
          width: Get.width * .9,
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
