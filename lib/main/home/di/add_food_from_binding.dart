import 'package:food_quest/main/home/presentation/controller/add_food_form_controller.dart';
import 'package:food_quest/main/home/presentation/controller/wheel_controller.dart';
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
