import 'package:flutter/material.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/data/source/food_service.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final FoodService _foodService = Get.find<FoodService>();
  final RxList<FoodModel> listFoodSelected = <FoodModel>[].obs;
  final TextEditingController userNameController = TextEditingController();
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

  Future<void> addFood(FoodModel food) async {
    await _foodService.addFood(food.toJson());
  }

  Future<void> deleteFood(String id) async {
    await _foodService.deleteFood(id);
  }
}
