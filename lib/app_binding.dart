import 'package:food_quest/core/config/theme/theme_controller.dart';
import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController(), fenix: true);
    DeepLinkService.init();
  }
}
