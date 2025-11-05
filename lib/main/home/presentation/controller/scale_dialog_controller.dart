import 'package:flutter/material.dart';
import 'package:food_quest/main/home/presentation/widgets/scale_transition_dialog.dart';
import 'package:get/get.dart';

// =========================== //
//  CONTROLLER CHO POPUP UI   //
// =========================== //

class ScaleDialogController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> scale;

  @override
  void onInit() {
    super.onInit();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();

    scale = CurvedAnimation(
      parent: animController,
      curve: Curves.elasticOut,
    );
  }

  void closeDialog() {
    animController.reverse().then((_) => Get.back());
  }

  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }
}

void showResultDialog(String result) {
  Get.dialog(
    ScaleTransitionDialog(result: result),
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
  );
}
