import 'package:food_quest/features/food/application/controller/deep_link_controller.dart';
import 'package:get/get.dart';

class AddFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeepLinkController());
  }
}
