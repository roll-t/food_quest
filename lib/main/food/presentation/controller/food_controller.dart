import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/data/source/food_service.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final FoodService _foodService = Get.find<FoodService>();
  final RxList<FoodModel> listFoodSelected = <FoodModel>[].obs;
  final TextEditingController foodNameController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString message = ''.obs;

  ///============================== [FUNCTIONS] ==============================
  Future<void> getFood() async {
    isLoading.value = true;
    _foodService.streamFoods().listen(
      (foods) {
        listFoodSelected.assignAll(foods);
        isLoading.value = false;
      },
      onError: (e) {
        message.value = 'Error loading foods: $e';
        isLoading.value = false;
      },
    );
  }

  Future<void> addFood() async {
    KeyboardUtils.hiddenKeyboard();
    DialogUtils.showProgressDialog();
    final success = await _foodService.addFood(FoodModel(
      name: foodNameController.text,
    ).toJson());
    Get.back();
    if (success) {
      DialogUtils.showAlert(
        alertType: AlertType.success,
        content: "Thêm thành công",
        onConfirm: () {
          Get.back();
          Get.back();
        },
      );
      resetData();
    }
  }

  void resetData() {
    foodNameController.clear();
  }

  Future<void> deleteFood(String id) async {
    await _foodService.deleteFood(id);
  }
}
