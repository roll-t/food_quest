import 'package:food_quest/features/food/application/controller/food_controller.dart';
import 'package:food_quest/features/food/data/source/food_service.dart';
import 'package:get/get.dart';

class FoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FoodService(),
      fenix: true,
    );
    Get.lazyPut(
      () => FoodController(
        Get.find(),
      ),
      fenix: true,
    );
  }
}
