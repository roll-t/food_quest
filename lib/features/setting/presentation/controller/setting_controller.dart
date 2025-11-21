import 'package:food_quest/core/local_storage/app_get_storage.dart';
import 'package:food_quest/core/utils/mixin_controller/language_mixin_controller.dart';
import 'package:get/get.dart';

class SettingController extends GetxController with LanguageMixinController {
  ///---> [Notification]
  final RxBool isNotificationEnabled =
      AppGetStorage.isNotificationEnabled().obs;
  void toggleNotification(bool value) {
    if (isNotificationEnabled.value == value) return;
    isNotificationEnabled.value = value;
    // LoadingUtils.showOverlayLoading(
    //   asyncFunction: () => NotificationService().toggleNotification(value),
    // );
  }
}
