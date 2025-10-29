import 'package:food_quest/core/services/api_client.dart';
import 'package:food_quest/core/services/internet_service.dart';
import 'package:food_quest/main/splash/presentation/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(InternetService());
    Get.put(ApiClient());
  }
}
