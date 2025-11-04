import 'dart:async';

import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:food_quest/core/extension/core/empty_extensions.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/home/feature/presentation/controller/scale_dialog_controller.dart';
import 'package:food_quest/main/home/feature/presentation/widgets/scale_transition_dialog.dart';
import 'package:get/get.dart';

class WheelController extends GetxController {
  // ---- Reactive states ----
  final RxBool isPressed = false.obs;
  final RxBool isSpinning = false.obs;
  final RxBool isLoading = true.obs;
  // ---- Stream for the wheel ----
  final StreamController<int> selected = StreamController<int>();
  late final FoodController foodController;
  // ---- Data ----
  final List<FoodModel> foods = [];

  final List<FoodModel> foodsShimmer = [
    FoodModel(),
    FoodModel(),
    FoodModel(),
    FoodModel(),
    FoodModel(),
  ];

  int? _selectedIndex;

  @override
  void onReady() async {
    super.onReady();
    initialData();
  }

  void initialData() async {
    final hasInit = Get.isRegistered<FoodController>(tag: "init");
    foodController = hasInit ? Get.find<FoodController>(tag: "init") : Get.find<FoodController>();
    foods.assignAll(foodController.listFoodOnWheel);
    Get.delete<FoodController>(tag: "init");
    if (foods.isNotEmpty) {}
    update(["WHEEL_ID"]);
  }

  // ---- Actions ----
  Future<void> spinWheel() async {
    if (isSpinning.value) return;

    isPressed.value = true;
    await Future.delayed(const Duration(milliseconds: 100));
    isPressed.value = false;

    isSpinning.value = true;

    _selectedIndex = Fortune.randomInt(0, foods.length);
    selected.add(_selectedIndex!);
  }

  void onSpinEnd() async {
    isSpinning.value = false;
    if (_selectedIndex != null) {
      // Đăng ký controller
      Get.put(ScaleDialogController());

      // Gọi dialog (không bọc Get.put() trong await)
      await Get.dialog(
        ScaleTransitionDialog(result: foods[_selectedIndex!].name.orNA()),
        barrierDismissible: false,
      );

      // Xoá controller sau khi dialog đóng
      if (Get.isRegistered<ScaleDialogController>()) {
        Get.delete<ScaleDialogController>();
      }
    }
  }

  // ---- Lifecycle ----
  @override
  void onClose() {
    selected.close();
    super.onClose();
  }
}
