import 'package:food_quest/features/home/presentation/controller/scale_dialog_controller.dart';
import 'package:food_quest/features/home/presentation/controller/wheel_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScaleDialogController());
    Get.lazyPut(
      () => WheelController(
        foodController: Get.find(),
      ),
    );
  }
}
