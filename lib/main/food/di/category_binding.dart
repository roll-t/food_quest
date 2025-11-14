import 'package:food_quest/core/utils/dependency_utils.dart';
import 'package:food_quest/main/food/presentation/controller/category_controller.dart';
import 'package:get/get.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    DependencyUtils.lazyPut(() => CategoryController());
  }
}
