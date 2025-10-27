import 'package:get/get.dart';

class CustomBinding {
  static T? put<T extends GetxController>(
    T controller, {
    bool permanent = false,
  }) {
    if (!Get.isRegistered<T>()) {
      return Get.put<T>(controller, permanent: permanent);
    }
    return null;
  }

  static void lazyPut<T extends GetxController>(
    T Function() builder, {
    bool fenix = false,
    bool permanent = false,
  }) {
    if (!Get.isRegistered<T>()) {
      Get.lazyPut<T>(builder, fenix: fenix);
    }
  }
}
