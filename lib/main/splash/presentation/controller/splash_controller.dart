import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/nav/presentation/page/navigation_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  late final FoodController foodController;

  @override
  Future<void> onReady() async {
    super.onReady();
    foodController = Get.find<FoodController>();
    await foodController.getFood();
    await Future.delayed(const Duration(milliseconds: 300));
    Get.offAllNamed(const NavigationPage().routeName);
  }
}
