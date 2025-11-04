import 'package:flutter/animation.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:get/get.dart';

class AddFoodFormController extends GetxController with GetSingleTickerProviderStateMixin {
  AddFoodFormController({
    required this.foodController,
    required this.listFoodSelected,
  });

  final FoodController foodController;

  /// Animation
  late final AnimationController scaleController;
  late final Animation<double> scaleAnimation;

  /// Reactive data
  final RxList<FoodModel> listFoodSelected;

  final RxSet<String> hiddenItems = <String>{}.obs;

  /// Suggestion / Recent items
  late final List<FoodModel> recentFoods;

  @override
  Future<void> onInit() async {
    super.onInit();
    _initAnimation();
    await _initializeData();
  }

  /// ---- Init Data ----
  Future<void> _initializeData() async {
    if (foodController.listFoodOnWheel.isEmpty) {
      await foodController.loadFoodOnWheel();
    }
    listFoodSelected.assignAll(foodController.listFoodOnWheel);
    recentFoods = List.generate(20, (i) => FoodModel(name: "Food $i"));
  }

  /// ---- Init Animation ----
  void _initAnimation() {
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

  /// ---- Remove Food Action ----
  Future<void> removeFood(FoodModel food) async {
    DialogUtils.showProgressDialog();

    await foodController.toggleSelected(food);

    final key = food.id ?? food.name;
    if (key != null) {
      hiddenItems.add(key);
      listFoodSelected.remove(food);
      hiddenItems.remove(key);
    }

    Get.back(); // hide loading
  }

  @override
  void onClose() {
    scaleController.dispose();
    super.onClose();
  }
}
