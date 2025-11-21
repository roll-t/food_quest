import 'package:food_quest/core/utils/binding/dependency_utils.dart';
import 'package:food_quest/features/category/application/controller/category_controller.dart';
import 'package:get/get.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    DependencyUtils.lazyPut(() => CategoryController());
  }
}
