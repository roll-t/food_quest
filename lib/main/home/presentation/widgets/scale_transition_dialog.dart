// =========================== //
//  UI HIỂN THỊ TRONG DIALOG  //
// =========================== //
import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/ui/widgets/buttons/primary_button.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/main/home/presentation/controller/scale_dialog_controller.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
          width: 90.w,
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
