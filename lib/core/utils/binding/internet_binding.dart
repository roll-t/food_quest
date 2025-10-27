import 'package:food_quest/core/utils/controller/internet_controller.dart';
import 'package:food_quest/core/utils/custom_binding.dart';
import 'package:get/get.dart';

class InternetBinding extends Bindings {
  @override
  void dependencies() {
    CustomBinding.put<InternetController>(InternetController());
  }
}
