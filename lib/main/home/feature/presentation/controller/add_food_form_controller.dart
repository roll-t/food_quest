import 'package:flutter/animation.dart';
import 'package:food_quest/main/home/data/model/food_model.dart';
import 'package:get/get.dart';

class AddFoodFormController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;
  final RxList<FoodModel> listFoodSelected = <FoodModel>[].obs;
  final RxSet<String> hiddenItems = <String>{}.obs;
  List<FoodModel> recentFoods = [];

  @override
  void onInit() {
    super.onInit();
    listFoodSelected.value = [
      FoodModel(name: "Pizza", image: "https://picsum.photos/200?1"),
      FoodModel(name: "Sushi", image: "https://picsum.photos/200?2"),
      FoodModel(name: "Burger", image: "https://picsum.photos/200?3"),
      FoodModel(name: "Salad", image: "https://picsum.photos/200?4"),
      FoodModel(name: "Noodles", image: "https://picsum.photos/200?5"),
    ];

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
    final key = food.id ?? food.name;
    hiddenItems.add(key);
    listFoodSelected.remove(food);
    hiddenItems.remove(key);
  }

  @override
  void onClose() {
    scaleController.dispose();
    super.onClose();
  }
}
