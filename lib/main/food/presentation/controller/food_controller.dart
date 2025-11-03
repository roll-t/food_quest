import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/data/source/food_service.dart';
import 'package:food_quest/main/food/presentation/controller/deep_link_controller.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final FoodService _foodService = Get.find<FoodService>();
  final RxList<FoodModel> listFoodSelected = <FoodModel>[].obs;
  final TextEditingController foodNameController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingListFood = false.obs;
  final RxString message = ''.obs;

  // Phân trang
  DocumentSnapshot? lastDocument;
  final int pageLimit = 18;

  ///============================== [FUNCTIONS] ==============================

  Future<void> getAllFoods() async {
    try {
      isLoading.value = true;
      final foods = await _foodService.getAllFoods();
      listFoodSelected.assignAll(foods);
    } catch (e) {
      message.value = 'Error loading foods: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNextPage() async {
    try {
      isLoading.value = true;
      final foods = await _foodService.fetchFoodsPage(
        limit: pageLimit,
        startAfterDoc: lastDocument,
      );
      if (foods.isNotEmpty) {
        listFoodSelected.addAll(foods);
        lastDocument = await _foodService.db.collection("foods").doc(foods.last.id).get();
      }
    } catch (e) {
      message.value = 'Error fetching foods page: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSelectedFoods() async {
    try {
      isLoading.value = true;
      final foods = await _foodService.getSelectedFoods();
      listFoodSelected.assignAll(foods);
    } catch (e) {
      message.value = 'Error loading selected foods: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔹 Kiểm tra dữ liệu trước khi thêm
  bool _validation() {
    if (foodNameController.text.isEmpty) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Không được bỏ trống tên",
      );
      return false;
    }
    return true;
  }

  Future<void> addFood() async {
    KeyboardUtils.hiddenKeyboard();

    if (!_validation()) return;

    DialogUtils.showProgressDialog();

    try {
      final FoodModel food;

      if (DeepLinkService.isOpenedFromShare) {
        final deepLinkController = Get.find<DeepLinkController>();
        food = FoodModel(
          name: foodNameController.text,
          metaDataModel: deepLinkController.metaData.value,
        );
      } else {
        food = FoodModel(
          name: foodNameController.text,
        );
      }

      final success = await _foodService.addFood(food);

      if (success) {
        Get.back();
        Fluttertoast.showToast(msg: "Lưu thành công");
        if (DeepLinkService.isOpenedFromShare) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        } else {
          resetData();
        }
      } else {
        Get.back();
        DialogUtils.showAlert(
          alertType: AlertType.error,
          content: "Thêm thất bại, thử lại",
        );
      }
    } catch (e) {
      Get.back();
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Lỗi: $e",
      );
    }
  }

  Future<void> deleteFood(String? id) async {
    DialogUtils.showConfirm(
      alertType: AlertType.warning,
      content: "Bạn có thật sự muốn xoá!",
      onConfirm: () async {
        try {
          DialogUtils.showProgressDialog();
          await _foodService.deleteFood(id!);
          await resetData();
          Get.back();
          Get.back();
        } catch (e) {
          message.value = 'Error deleting food: $e';
        }
      },
    );
  }

  /// 🔹 Cập nhật food
  Future<void> updateFood(FoodModel food) async {
    try {
      await _foodService.updateFood(food.id!, food.toJson());
      // Cập nhật local list
      int index = listFoodSelected.indexWhere((f) => f.id == food.id);
      if (index != -1) listFoodSelected[index] = food;
      listFoodSelected.refresh();
    } catch (e) {
      message.value = 'Error updating food: $e';
    }
  }

  Future<void> toggleSelected(FoodModel food) async {
    try {
      await _foodService.toggleSelected(food.id!, !food.isSelected);
      food.isSelected = !food.isSelected;
      listFoodSelected.refresh();
    } catch (e) {
      message.value = 'Error toggling selection: $e';
    }
  }

  Future<void> refreshFoods() async {
    try {
      isLoading.value = true;
      final foods = await _foodService.getAllFoods();
      listFoodSelected.assignAll(foods);
      lastDocument = null;
    } catch (e) {
      message.value = 'Error refreshing foods: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetData() async {
    foodNameController.clear();
    refreshFoods();
  }

  void streamFoodsRealtime() {
    _foodService.streamFoods().listen(
      (foods) {
        listFoodSelected.assignAll(foods);
      },
      onError: (e) {
        message.value = 'Error loading foods realtime: $e';
      },
    );
  }

  void streamSelectedFoodsRealtime() {
    _foodService.streamSelectedFoods().listen(
      (foods) {
        listFoodSelected.assignAll(foods);
      },
      onError: (e) {
        message.value = 'Error loading selected foods realtime: $e';
      },
    );
  }
}
