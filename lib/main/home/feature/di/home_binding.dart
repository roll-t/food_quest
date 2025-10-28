import 'package:food_quest/main/home/feature/presentation/controller/home_controller.dart';
import 'package:food_quest/main/home/feature/presentation/controller/scale_dialog_controller.dart';
import 'package:food_quest/main/home/feature/presentation/controller/wheel_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
    Get.lazyPut(() => WheelController());
    Get.lazyPut(() => ScaleDialogController());
  }
}
