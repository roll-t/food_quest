import 'package:food_quest/main/food/data/source/food_service.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:get/get.dart';

class FoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FoodService(),
      fenix: true,
    );
    Get.put(
      FoodController(),
      permanent: true,
    );
  }
}
