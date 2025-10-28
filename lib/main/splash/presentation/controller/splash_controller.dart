import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/main/nav/presentation/page/navigation_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(milliseconds: 300));
    Get.offAllNamed(const NavigationPage().routeName);
    AppLogger.i("Đã đăng nhập");
    // if (AppGetStorage.isLoggedIn()) {

    // } else {
    //   // Get.offAllNamed(const LoginPage().routeName);
    //   AppLogger.i("Chưa đăng nhập");
    // }
  }
}
