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
  ///---> [CONTROLLER_EXTRACT]
  final FoodController foodController;

  WheelController({
    required this.foodController,
  });

  ///---> [VARIABLES]
  final RxBool isPressed = false.obs;
  final RxBool isSpinning = false.obs;
  final RxBool isLoading = true.obs;
  final List<FoodModel> foods = [];
  int? _selectedIndex;
  final StreamController<int> selected = StreamController<int>();
  final List<FoodModel> foodsShimmer = List.generate(5, (_) => FoodModel());

  ///---> [OVERRIDE_LIFECYCLE]
  @override
  void onInit() {
    super.onInit();
    handleArgumentFromGet();
  }

  @override
  void onReady() async {
    super.onReady();
    _initialData();
  }

  @override
  void onClose() {
    selected.close();
    super.onClose();
  }

  ///---> [DATA]
  Future<void> _initialData() async {
    if (argsData?.isNotEmpty ?? false) {
      foods.assignAll(argsData ?? []);
    } else {
      await foodController.loadFoodOnWheel();
      foods.assignAll(foodController.listFoodOnWheel);
    }
    update(["WHEEL_ID"]);
  }

  Future<void> callbackData() async {
    await foodController.loadFoodOnWheel();
    foods.assignAll(foodController.listFoodOnWheel);
    update(["WHEEL_ID"]);
  }

  ///---> [EVENTS]
  Future<void> onSpinWheel() async {
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
      Get.put(ScaleDialogController());
      await Get.dialog(
        ScaleTransitionDialog(result: foods[_selectedIndex!].name.orNA()),
        barrierDismissible: false,
      );
      if (Get.isRegistered<ScaleDialogController>()) {
        Get.delete<ScaleDialogController>();
      }
    }
  }
}
