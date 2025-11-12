import 'package:food_quest/core/utils/dependency_utils.dart';
import 'package:food_quest/main/food/data/source/food_service.dart';
import 'package:food_quest/main/food/presentation/controller/add_from_deep_link_controller.dart';
import 'package:food_quest/main/food/presentation/controller/deep_link_controller.dart';
import 'package:get/get.dart';

class AddFromDeepLinkBinding extends Bindings {
  @override
  void dependencies() {
    DependencyUtils.lazyPut(() => FoodService());
    DependencyUtils.lazyPut(() => DeepLinkController());
    DependencyUtils.lazyPut(() => AddFromDeepLinkController(Get.find()));
  }
}
