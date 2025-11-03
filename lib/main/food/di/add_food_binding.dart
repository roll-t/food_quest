import 'package:food_quest/main/food/presentation/controller/deep_link_controller.dart';
import 'package:get/get.dart';

class AddFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeepLinkController());
  }
}
