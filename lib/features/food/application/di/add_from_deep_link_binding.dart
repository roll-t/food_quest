import 'package:food_quest/core/utils/binding/dependency_utils.dart';
import 'package:food_quest/features/food/application/controller/add_from_deep_link_controller.dart';
import 'package:food_quest/features/food/application/controller/deep_link_controller.dart';
import 'package:food_quest/features/food/data/source/food_service.dart';
import 'package:get/get.dart';

class AddFromDeepLinkBinding extends Bindings {
  @override
  void dependencies() {
    DependencyUtils.lazyPut(() => FoodService());
    DependencyUtils.lazyPut(() => DeepLinkController());
    DependencyUtils.lazyPut(() => AddFromDeepLinkController(Get.find()));
  }
}
