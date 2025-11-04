import 'package:flutter/animation.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:get/get.dart';

class AddFoodFormController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;
  final FoodController foodController = Get.find<FoodController>();
  final RxList<FoodModel> listFoodSelected = <FoodModel>[].obs;
  final RxSet<String> hiddenItems = <String>{}.obs;
  List<FoodModel> recentFoods = [];
  @override
  void onInit() {
    super.onInit();
    listFoodSelected.value = foodController.listFoodOnWheel;
    recentFoods = List.generate(
      20,
      (i) => FoodModel(
        name: "Food $i",
        image: "https://picsum.photos/200?random=$i",
      ),
    );

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

  void removeFood(FoodModel food) async {
    DialogUtils.showProgressDialog();
    await foodController.toggleSelected(food);
    final key = food.id ?? food.name;
    hiddenItems.add(key!);
    listFoodSelected.remove(food);
    hiddenItems.remove(key);
    Get.back();
  }

  @override
  void onClose() {
    scaleController.dispose();
    super.onClose();
  }
}
