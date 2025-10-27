import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExpandController extends GetxController {
  final Key? key;

  ExpandController({this.key});

  RxBool isExpanded = true.obs;

  void toggle() {
    isExpanded.value = !isExpanded.value;
  }

  @override
  void onClose() {
    isExpanded.close();
    super.onClose();
  }
}
