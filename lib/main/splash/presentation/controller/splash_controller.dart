import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/food/presentation/page/add_food_page.dart';
import 'package:food_quest/main/nav/presentation/page/navigation_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  late FoodController foodController;

  @override
  Future<void> onReady() async {
    super.onReady();
    foodController = Get.find<FoodController>(tag: "init");
    if (DeepLinkService.sharedText != null) {
      await foodController.fetchNextPage();
      Get.offAllNamed(
        const AddFoodPage().routeName,
        arguments: DeepLinkService.sharedText,
      );
      return;
    }
    await foodController.loadFoodOnWheel();
    Get.offAllNamed(const NavigationPage().routeName);
  }
}
