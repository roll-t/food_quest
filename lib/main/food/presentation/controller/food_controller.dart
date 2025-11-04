import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:food_quest/core/utils/mixin_controller/argument_handle_mixin_controller.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/data/source/food_service.dart';
import 'package:food_quest/main/food/presentation/controller/deep_link_controller.dart';
import 'package:food_quest/main/splash/presentation/controller/splash_controller.dart';
import 'package:get/get.dart';

class FoodController extends GetxController with ArgumentHandlerMixinController<SplashArg> {
  FoodController(this._foodService);
  final FoodService _foodService;
  final RxList<FoodModel> listFoods = <FoodModel>[].obs;
  final RxList<FoodModel> selectedFoods = <FoodModel>[].obs;
  final foodNameController = TextEditingController();
  final message = ''.obs;
  final isLoading = false.obs;
  final isMultiSelectMode = false.obs;
  final isLoadingListFood = false.obs;
  final List<FoodModel> listFoodOnWheel = [];
  DocumentSnapshot? lastDocument;
  static const int pageLimit = 18;

  @override
  void onInit() async {
    super.onInit();

    bool hasArg = handleArgumentFromGet();
    if (hasArg) {
      listFoods.assignAll(argsData?.listFood ?? []);
    }
  }

  // ===========================================================================
  // ✅ COMMON HELPERS
  // ===========================================================================
  Future<void> _loadList(
    Future<List<FoodModel>> Function() source,
    RxBool loadingState, {
    String? updateId,
  }) async {
    try {
      loadingState.value = true;
      if (updateId != null) update([updateId]);
      final foods = await source();
      listFoods.assignAll(foods);
    } catch (e) {
      message.value = "Error: $e";
    } finally {
      loadingState.value = false;
      if (updateId != null) update([updateId]);
    }
  }

  // ===========================================================================
  // ✅ UI CONTROLS
  // ===========================================================================

  void enableMultiSelect() {
    isMultiSelectMode.value = true;
    update(["HANDLE_BAR_ID"]);
  }

  void toggleFoodSelection(FoodModel food) {
    selectedFoods.contains(food) ? selectedFoods.remove(food) : selectedFoods.add(food);

    selectedFoods.refresh();

    if (selectedFoods.isEmpty) {
      isMultiSelectMode.value = false;
      update(["HANDLE_BAR_ID"]);
    }
  }

  // ===========================================================================
  // ✅ LOAD & PAGINATION
  // ===========================================================================

  Future<void> getSelectedFoods() {
    return _loadList(_foodService.getSelectedFoods, isLoading);
  }

  Future<void> fetchNextPage() async {
    try {
      isLoading.value = true;
      final foods = await _foodService.fetchFoodsPage(
        limit: pageLimit,
        startAfterDoc: lastDocument,
      );

      if (foods.isNotEmpty) {
        listFoods.addAll(foods);
        lastDocument = await _foodService.db.collection("foods").doc(foods.last.id).get();
      }
    } catch (e) {
      message.value = 'Error fetching foods page: $e';
    } finally {
      isLoading.value = false;
    }
    update(["LIST_FOOD_RECOMMEND_ID"]);
  }

  Future<void> loadFoodOnWheel() async {
    try {
      isLoading.value = true;
      final foods = await _foodService.getSelectedFoods();
      listFoodOnWheel
        ..clear()
        ..addAll(foods);
    } catch (e) {
      message.value = 'Error loading foods for wheel: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // ===========================================================================
  // ✅ CRUD ACTIONS
  // ===========================================================================

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
        if (DeepLinkService.isOpenedFromShare) _exitApp();
        resetData();
      } else {
        DialogUtils.showAlert(
          alertType: AlertType.error,
          content: "Thêm thất bại, thử lại",
        );
      }
    });
  }

  Future<void> deleteFood(String? id) async {
    DialogUtils.showConfirm(
      alertType: AlertType.warning,
      content: "Bạn có thật sự muốn xoá!",
      onConfirm: () async {
        await Utils.runWithLoading(
          () async {
            await _foodService.deleteFood(id!);
            await resetData();
            Get.back();
          },
        );
      },
    );
  }

  Future<void> deleteSelectedFoods() async {
    if (selectedFoods.isEmpty) return;

    DialogUtils.showConfirm(
      alertType: AlertType.warning,
      content: "Bạn có chắc muốn xoá ${selectedFoods.length} món?",
      onConfirm: () async {
        await Utils.runWithLoading(() async {
          final ids = selectedFoods.map((e) => e.id!).toList();
          final success = await _foodService.deleteMultiFood(ids);
          if (!success) {
            DialogUtils.showAlert(
              alertType: AlertType.error,
              content: "Xoá thất bại, thử lại!",
            );
            return;
          }

          Fluttertoast.showToast(msg: "Đã xoá ${ids.length} món");
          selectedFoods.clear();
          isMultiSelectMode.value = false;
          await refreshFoods();
          Get.back();
        });
      },
    );
  }

  Future<void> updateFood(FoodModel food) async {
    try {
      await _foodService.updateFood(food.id!, food.toJson());
      final index = listFoods.indexWhere((f) => f.id == food.id);
      if (index != -1) listFoods[index] = food;
      listFoods.refresh();
    } catch (e) {
      message.value = 'Error updating food: $e';
    }
  }

  Future<void> toggleSelected(FoodModel food) async {
    try {
      final newValue = !food.isSelected;
      await _foodService.toggleSelected(food.id!, newValue);
      food.isSelected = newValue;
      listFoods.refresh();
    } catch (e) {
      message.value = 'Error toggling selection: $e';
    }
  }

  /// Toggle multi
  Future<void> onSelectMultiChoiceFood() async {
    if (selectedFoods.isEmpty) return;

    await Utils.runWithLoading(
      () async {
        final ids = selectedFoods.map((e) => e.id!).toList();
        final success = await _foodService.toggleSelectedMulti(ids, true);

        if (success) {
          for (final food in selectedFoods) {
            food.isSelected = true;
          }
          selectedFoods.refresh();
        } else {
          DialogUtils.showAlert(
            alertType: AlertType.error,
            content: "Cập nhật chọn nhiều thất bại!",
          );
        }
      },
    );
  }

  // ===========================================================================
  // ✅ STREAM
  // ===========================================================================

  void streamFoodsRealtime() {
    _foodService.streamFoods().listen(
          (foods) => listFoods.assignAll(foods),
          onError: (e) => message.value = 'Error loading foods realtime: $e',
        );
  }

  void streamSelectedFoodsRealtime() {
    _foodService.streamSelectedFoods().listen(
          (foods) => listFoods.assignAll(foods),
          onError: (e) => message.value = 'Error loading selected foods realtime: $e',
        );
  }

  // ===========================================================================
  // ✅ HELPER / VALIDATION
  // ===========================================================================

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

  Future<void> refreshFoods() async {
    lastDocument = null;
    listFoods.clear();
    await fetchNextPage();
  }

  Future<void> resetData() async {
    if (isMultiSelectMode.value) return;
    foodNameController.clear();
    await refreshFoods();
  }

  void _exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
