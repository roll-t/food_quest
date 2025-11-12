import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_quest/core/config/const/app_const.dart';
import 'package:food_quest/core/config/const/app_enum.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/core/utils/mixin_controller/argument_handle_mixin_controller.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/data/source/food_service.dart';
import 'package:food_quest/main/splash/presentation/controller/splash_controller.dart';
import 'package:get/get.dart';

class FoodController extends GetxController with ArgumentHandlerMixinController<SplashArg> {
  FoodController(this._foodService);

  // ─────────────────────────────────────────────
  // 🔹 CONSTANTS & SERVICES & STATES
  // ─────────────────────────────────────────────

  static const int pageLimit = 18;
  final FoodService _foodService;

  final isLoading = false.obs;
  final isLoadingListSaved = false.obs;
  final isMultiSelectMode = false.obs;
  final message = ''.obs;

  final RxList<FoodModel> listFoods = <FoodModel>[].obs;
  final RxList<FoodModel> selectedFoodsMarker = <FoodModel>[].obs;
  final RxList<FoodModel> selectedFoodsHandler = <FoodModel>[].obs;

  final List<FoodModel> listFoodOnWheel = [];

  DocumentSnapshot? lastDocument;

  // ─────────────────────────────────────────────
  // 🔹 INIT & ARGUMENT HANDLING
  // ─────────────────────────────────────────────

  @override
  void onInit() async {
    super.onInit();
    bool hasArg = handleArgumentFromGet();
    if (hasArg && (argsData?.listFood?.isNotEmpty ?? false)) {
      listFoods.assignAll(argsData?.listFood ?? []);
    }
  }

  // ─────────────────────────────────────────────
  // 🔹 UI CONTROLS & MULTI SELECT
  // ─────────────────────────────────────────────

  void enableMultiSelect() {
    isMultiSelectMode.value = true;
    update(["HANDLE_BAR_ID"]);
  }

  void toggleFoodSelection(FoodModel food) {
    selectedFoodsHandler.contains(food) ? selectedFoodsHandler.remove(food) : selectedFoodsHandler.add(food);
    selectedFoodsHandler.refresh();
    if (selectedFoodsHandler.isEmpty) {
      isMultiSelectMode.value = false;
      update(["HANDLE_BAR_ID"]);
    }
  }

  // ─────────────────────────────────────────────
  // 🔹 LOAD & PAGINATION
  // ─────────────────────────────────────────────

  Future<void> getSelectedFoods() {
    return _loadList(_foodService.getSelectedFoods, isLoadingListSaved);
  }

  Future<void> fetchNextPage() async {
    try {
      isLoadingListSaved.value = true;
      update(["LIST_FOOD_RECOMMEND_ID"]);

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
      isLoadingListSaved.value = false;
      update(["LIST_FOOD_RECOMMEND_ID"]);
    }
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

  // ─────────────────────────────────────────────
  // 🔹 CRUD ACTIONS
  // ─────────────────────────────────────────────

  /// 🔹 Lấy 20 món được chọn gần đây nhất
  Future<List<FoodModel>> getRecentSelectedFoods({int limit = 20}) async {
    try {
      final foods = await _foodService.getRecentFoods(limit: limit);
      return foods;
    } catch (e) {
      message.value = "Error fetching recent selected foods: $e";
      return [];
    }
  }

  Future<void> deleteFood(String? id) async {
    DialogUtils.showConfirm(
      alertType: AlertType.warning,
      content: "Bạn có thật sự muốn xoá!",
      onConfirm: () async {
        await Utils.runWithLoading(() async {
          await _foodService.deleteFood(id!);
          await resetData();
          Get.back();
        });
      },
    );
  }

  Future<void> deleteMultiSelectedFoods() async {
    if (selectedFoodsHandler.isEmpty) return;

    DialogUtils.showConfirm(
      alertType: AlertType.warning,
      content: "Bạn có chắc muốn xoá ${selectedFoodsHandler.length} món?",
      onConfirm: () async {
        await Utils.runWithLoading(() async {
          final ids = selectedFoodsHandler.map((e) => e.id!).toList();
          final success = await _foodService.deleteMultiFood(ids);

          if (!success) {
            DialogUtils.showAlert(
              alertType: AlertType.error,
              content: "Xoá thất bại, thử lại!",
            );
            return;
          }

          Fluttertoast.showToast(msg: "Đã xoá ${ids.length} món");
          selectedFoodsHandler.clear();
          isMultiSelectMode.value = false;
          await refreshFoods();
          resetSettings();
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

  Future<void> toggleSelected(FoodModel food, {bool? isSelect}) async {
    try {
      await _foodService.toggleSelected(food.id!, isSelect ?? !food.isSelected);
      listFoods.refresh();
    } catch (e) {
      message.value = 'Error toggling selection: $e';
    }
  }

  Future<void> onSelectMultiChoiceFood() async {
    final int remaining = AppConst.MAX_WHEEL_COUNT - selectedFoodsMarker.length;
    if (remaining <= 0) {
      Fluttertoast.showToast(msg: "Tối đa chỉ được ${AppConst.MAX_WHEEL_COUNT} món thôi!");
      return;
    }
    if (selectedFoodsHandler.length > remaining) {
      Fluttertoast.showToast(msg: "Chỉ thêm được $remaining món nữa thôi!");
      return;
    }

    if (selectedFoodsHandler.isEmpty) {
      Fluttertoast.showToast(msg: "Chưa chọn món nào");
      return;
    }

    final ids = selectedFoodsHandler.map((e) => e.id!).toList();

    await Utils.runWithLoading(() async {
      final success = await _foodService.toggleSelectedMulti(ids, true);

      if (!success) {
        DialogUtils.showAlert(
          alertType: AlertType.error,
          content: "Cập nhật thất bại, thử lại!",
        );
        return;
      }

      for (final food in selectedFoodsHandler) {
        food.isSelected = true;
      }

      selectedFoodsMarker.addAll(selectedFoodsHandler);
      selectedFoodsHandler.clear();
      isMultiSelectMode.value = false;
      update(["HANDLE_BAR_ID"]);

      Fluttertoast.showToast(msg: "Đã chọn ${ids.length} món");
      listFoods.refresh();
    });
  }

  // ─────────────────────────────────────────────
  // 🔹 REALTIME STREAMS
  // ─────────────────────────────────────────────

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

  // ─────────────────────────────────────────────
  // 🔹 HELPER / RESET / VALIDATION
  // ─────────────────────────────────────────────

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

  Future<void> refreshFoods() async {
    lastDocument = null;
    listFoods.clear();
    await fetchNextPage();
  }

  Future<void> resetData() async {
    if (isMultiSelectMode.value) return;
    await refreshFoods();
  }

  void resetSettings() {
    isMultiSelectMode.value = false;
    selectedFoodsHandler.clear();
    message.value = '';
    lastDocument = null;
    update([
      "HANDLE_BAR_ID",
      "LIST_FOOD_RECOMMEND_ID",
    ]);
  }

  void _exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
