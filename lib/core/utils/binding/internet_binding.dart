import 'package:food_quest/core/utils/binding/dependency_utils.dart';
import 'package:food_quest/core/utils/controller/internet_controller.dart';
import 'package:get/get.dart';

class InternetBinding extends Bindings {
  @override
  void dependencies() {
    DependencyUtils.put<InternetController>(() => InternetController());
  }
}
