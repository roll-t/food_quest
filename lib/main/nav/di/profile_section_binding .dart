// ignore: file_names
import 'package:food_quest/main/setting/presentation/controller/setting_controller.dart';
import 'package:get/get.dart';

class ProfileSectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingController(), permanent: true);
  }
}
