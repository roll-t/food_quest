import 'package:flutter/animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/food/presentation/page/add_food_page.dart';
import 'package:food_quest/main/home/feature/presentation/controller/wheel_controller.dart';
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

  ///---> [VARIABLES]
  bool hasEdited = false;
  final RxList<FoodModel> listFoodSelected;
  final RxSet<String> hiddenItems = <String>{}.obs;
  late final List<FoodModel> recentFoods;
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
  void onClose() async {
    if (hasEdited) {
      await Get.find<WheelController>().callbackData();
    }
    scaleController.dispose();
    super.onClose();
  }

  ///---> [INIT_DATA]
  Future<void> _loadInitialData() async {
    if (listFoodSelected.isEmpty) {
      isLoadingSelectedFoods.value = true;
      await foodController.loadFoodOnWheel();
      listFoodSelected.assignAll(foodController.listFoodOnWheel);
      isLoadingSelectedFoods.value = false;
    }
    recentFoods = List.generate(20, (i) => FoodModel(name: "Food $i"));
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
    DialogUtils.showProgressDialog();
    await foodController.toggleSelected(food);
    final key = food.id ?? food.name;
    if (key != null) {
      hiddenItems.add(key);
      listFoodSelected.remove(food);
      hiddenItems.remove(key);
    }
    hasEdited = true;
    Get.back();
  }

  void onGoToAddFoodPage() {
    if (listFoodSelected.length >= 5) {
      Fluttertoast.showToast(msg: "Tối đa 5 phần");
      return;
    }

    foodController.selectedFoodsMarker.value = listFoodSelected;
    if (foodController.listFoods.isEmpty) {
      foodController.fetchNextPage();
    }

    Get.toNamed(
      const AddFoodPage().routeName,
    );
  }
}
