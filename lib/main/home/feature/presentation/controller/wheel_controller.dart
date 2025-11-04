import 'dart:async';

import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:food_quest/core/extension/core/empty_extensions.dart';
import 'package:food_quest/core/utils/mixin_controller/argument_handle_mixin_controller.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/home/feature/presentation/controller/scale_dialog_controller.dart';
import 'package:food_quest/main/home/feature/presentation/widgets/scale_transition_dialog.dart';
import 'package:get/get.dart';

class WheelController extends GetxController with ArgumentHandlerMixinController<List<FoodModel>> {
  WheelController({
    required this.foodController,
  });
  final FoodController foodController;

  // ---- Reactive states ----
  final RxBool isPressed = false.obs;
  final RxBool isSpinning = false.obs;
  final RxBool isLoading = true.obs;

  // ---- Stream for the wheel ----
  final StreamController<int> selected = StreamController<int>();
  // ---- Data ----
  final List<FoodModel> foods = [];
  int? _selectedIndex;
  final List<FoodModel> foodsShimmer = List.generate(5, (_) => FoodModel());

  @override
  void onInit() {
    super.onInit();
    handleArgumentFromGet();
  }

  @override
  void onReady() async {
    super.onReady();
    initialData();
  }

  Future<void> initialData() async {
    if (argsData?.isNotEmpty ?? false) {
      foods.assignAll(argsData ?? []);
    } else {
      await foodController.loadFoodOnWheel();
      foods.assignAll(foodController.listFoodOnWheel);
    }
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
