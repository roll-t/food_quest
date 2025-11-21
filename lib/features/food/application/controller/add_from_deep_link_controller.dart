import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/features/food/application/controller/deep_link_controller.dart';
import 'package:food_quest/features/food/data/model/food_model.dart';
import 'package:food_quest/features/food/data/source/food_service.dart';
import 'package:get/get.dart';

class AddFromDeepLinkController extends GetxController {
  final FoodService _foodService;
  AddFromDeepLinkController(this._foodService);
  final foodNameController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  onInit() async {
    super.onInit();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;
  }

  Future<void> addFood() async {
    await KeyboardUtils.hiddenKeyboard(isDelay: true);
    if (!_validateInput()) return;
    await Utils.runWithLoading(() async {
      final food = DeepLinkService.isOpenedFromShare
          ? FoodModel(
              name: foodNameController.text,
              metaDataModel: Get.find<DeepLinkController>().metaData.value,
            )
          : FoodModel(name: foodNameController.text);

      final success = await _foodService.addFood(food);

      if (success) {
        Fluttertoast.showToast(msg: "Lưu thành công");
        if (DeepLinkService.isOpenedFromShare) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        } else {
          Get.back();
        }
      } else {
        DialogUtils.showAlert(
          alertType: AlertType.error,
          content: "Thêm thất bại, thử lại",
        );
      }
    });
  }

  bool _validateInput() {
    if (foodNameController.text.isEmpty) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Không được bỏ trống tên",
      );
      return false;
    }
    return true;
  }
}
