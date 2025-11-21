import 'package:food_quest/features/food/application/controller/add_food_form_controller.dart';
import 'package:food_quest/features/home/presentation/controller/wheel_controller.dart';
import 'package:get/get.dart';

class AddFoodFromBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AddFoodFormController(
        foodController: Get.find(),
        listFoodSelected: Get.find<WheelController>().foods.obs,
      ),
      fenix: true,
    );
  }
}
