// ignore: file_names
import 'package:food_quest/main/setting/presentation/controller/setting_controller.dart';
import 'package:food_quest/main/user/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingController(), permanent: true);
    Get.put(ProfileController());
  }
}
