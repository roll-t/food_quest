import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/features/food/application/controller/food_controller.dart';
import 'package:food_quest/features/food/data/model/food_model.dart';
import 'package:food_quest/features/food/presentation/page/add_from_deep_link_page.dart';
import 'package:food_quest/features/nav/presentation/page/navigation_page.dart';
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
  final List<FoodModel> listFood = [];

  SplashController();

  @override
  Future<void> onReady() async {
    super.onReady();

    if (DeepLinkService.sharedText != null) {
      Get.offAllNamed(
        const AddFromDeepLinkPage().routeName,
        arguments: SplashArg(
          deepLinkText: DeepLinkService.sharedText,
          listFood: listFood,
        ),
      );
      return;
    }

    final FoodController foodController = Get.find<FoodController>();
    await foodController.loadFoodOnWheel();
    listFood.addAll(foodController.listFoodOnWheel);
    Get.offAllNamed(
      const NavigationPage().routeName,
      arguments: listFood,
    );
  }
}
