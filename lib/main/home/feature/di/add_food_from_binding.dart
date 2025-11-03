import 'package:food_quest/main/home/feature/presentation/controller/add_food_form_controller.dart';
import 'package:get/get.dart';

class AddFoodFromBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFoodFormController());
  }
}
