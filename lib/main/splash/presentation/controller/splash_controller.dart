import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/food/presentation/page/add_food_page.dart';
import 'package:food_quest/main/nav/presentation/page/navigation_page.dart';
import 'package:get/get.dart';

class SplashArg {
  String? deepLinkText;
  List<FoodModel>? listFood;
  List<FoodModel>? listFoodSelected;
  bool isInit;
  SplashArg({
    this.deepLinkText,
    this.listFood,
    this.listFoodSelected,
    this.isInit = false,
  });
}

class SplashController extends GetxController {
  final FoodController foodController;
  final List<FoodModel> listFood = [];

  SplashController({required this.foodController});

  @override
  Future<void> onReady() async {
    super.onReady();

    if (DeepLinkService.sharedText != null) {
      await foodController.fetchNextPage();
      listFood.addAll(foodController.listFoods);
      Get.offAllNamed(
        const AddFoodPage().routeName,
        arguments: SplashArg(
          deepLinkText: DeepLinkService.sharedText,
          listFood: listFood,
        ),
      );
      return;
    }
    await foodController.loadFoodOnWheel();
    listFood.addAll(foodController.listFoodOnWheel);
    Get.offAllNamed(
      const NavigationPage().routeName,
      arguments: listFood,
    );
  }
}
