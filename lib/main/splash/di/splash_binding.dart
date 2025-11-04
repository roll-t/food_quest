import 'package:food_quest/core/services/api/api_client.dart';
import 'package:food_quest/core/services/internet_service.dart';
import 'package:food_quest/main/food/data/source/food_service.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/splash/presentation/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(InternetService());
    Get.put(ApiClient());
    Get.lazyPut(
      () => FoodService(),
      fenix: true,
    );
    Get.put(
      FoodController(),
      tag: "init",
    );
  }
}
