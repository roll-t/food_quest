import 'package:food_quest/core/services/internet_service.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  final _service = Get.find<InternetService>();

  @override
  void onReady() async {
    super.onReady();
    if (!Get.isDialogOpen!) {
      final check = await _service.checkNetwork();
      _service.showSnackbar(check);
    }
  }
}
