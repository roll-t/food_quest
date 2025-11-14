import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/food/presentation/page/add_food_page.dart';
import 'package:food_quest/main/home/presentation/controller/wheel_controller.dart';
import 'package:get/get.dart';

class AddFoodFormController extends GetxController with GetSingleTickerProviderStateMixin {
  ///---> [CONTROLLER_EXTRACT]
  final FoodController foodController;

  AddFoodFormController({
    required this.foodController,
    required this.listFoodSelected,
  });

  ///---> [LOADING_VARIABLES]
  final RxBool isLoadingSelectedFoods = false.obs;
  final RxBool isLoadingRecentFoods = false.obs;

  ///---> [VARIABLES]
  final RxList<FoodModel> listFoodSelected;
  final RxSet<String> hiddenItems = <String>{}.obs;
  final RxList<FoodModel> recentFoods = <FoodModel>[].obs;
  late final AnimationController scaleController;
  late final Animation<double> scaleAnimation;

  ///---> [OVERRIDE_LIFECYCLE]
  @override
  Future<void> onInit() async {
    super.onInit();
    _setupAnimation();
    await _loadInitialData();
  }

  @override
  void onClose() {
    Get.find<WheelController>().foods = listFoodSelected;
    Get.find<WheelController>().callbackData();
    scaleController.dispose();
    super.onClose();
  }

  ///---> [INIT_DATA]
  Future<void> _loadInitialData() async {
    try {
      isLoadingSelectedFoods.value = true;
      if (listFoodSelected.isEmpty) {
        await foodController.loadFoodOnWheel();
        listFoodSelected.assignAll(foodController.listFoodOnWheel);
      }
      isLoadingSelectedFoods.value = false;

      isLoadingRecentFoods.value = true;
      final recentList = await foodController.getRecentSelectedFoods(limit: 20);
      recentFoods.assignAll(recentList);
      isLoadingRecentFoods.value = false;
    } catch (e) {
      Fluttertoast.showToast(msg: "Lỗi khi tải dữ liệu: $e");
      isLoadingRecentFoods.value = false;
      isLoadingSelectedFoods.value = false;
    }
  }

  ///---> [ANIMATION]
  void _setupAnimation() {
    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    scaleAnimation = CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeOutBack,
    );

    scaleController.forward();
  }

  ///---> [EVENTS]
  Future<void> onRemoveFood(FoodModel food) async {
    try {
      DialogUtils.showProgressDialog();

      // Cập nhật trạng thái chọn trong DB
      await foodController.toggleSelected(food, isSelect: false);

      final key = food.id ?? food.name;
      if (key != null) {
        hiddenItems.add(key);

        // Remove bằng ID thay vì object
        listFoodSelected.removeWhere((f) => f.id == food.id || f.name == food.name);

        // Chờ animation (nếu cần)
        await Future.delayed(const Duration(milliseconds: 200));
        hiddenItems.remove(key);
      }

      // Update lại danh sách recent
      final now = Timestamp.fromDate(DateTime.now());
      final existingIndex = recentFoods.indexWhere((f) => f.id == food.id);
      final updatedFood = food.copyWith(isSelected: false, recentSelect: now);

      if (existingIndex >= 0) {
        recentFoods[existingIndex] = updatedFood;
      } else {
        recentFoods.add(updatedFood);
      }

      // Giới hạn 20 phần tử và sắp xếp
      recentFoods.sort((a, b) {
        final tA = a.recentSelect?.toDate().millisecondsSinceEpoch ?? 0;
        final tB = b.recentSelect?.toDate().millisecondsSinceEpoch ?? 0;
        return tB.compareTo(tA);
      });

      if (recentFoods.length > 20) {
        recentFoods.removeRange(20, recentFoods.length);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Lỗi khi xóa món: $e");
    } finally {
      Get.back(); // đóng dialog an toàn
    }
  }

  Future<void> onSelectRecentFood(FoodModel food) async {
    if (listFoodSelected.length >= 5) {
      Fluttertoast.showToast(msg: "Tối đa 5 món");
      return;
    }

    try {
      DialogUtils.showProgressDialog();

      final now = Timestamp.fromDate(DateTime.now());
      final updatedFood = food.copyWith(isSelected: true, recentSelect: now);

      await foodController.toggleSelected(updatedFood, isSelect: true);

      listFoodSelected.add(updatedFood);

      recentFoods.removeWhere((f) => f.id == food.id || f.name == food.name);
    } catch (e) {
      Fluttertoast.showToast(msg: "Lỗi khi chọn món: $e");
    } finally {
      Get.back();
    }
  }

  void onGoToAddFoodPage() {
    DialogUtils.showProgressDialog();
    Get.back();
    if (listFoodSelected.length >= 5) {
      Fluttertoast.showToast(msg: "Tối đa 5 phần");
      return;
    }

    foodController.selectedFoodsMarker.value = listFoodSelected;

    if (foodController.listFoods.isEmpty) {
      foodController.fetchNextPage();
    }

    foodController.resetSettings();

    Get.toNamed(const AddFoodPage().routeName);
  }
}
