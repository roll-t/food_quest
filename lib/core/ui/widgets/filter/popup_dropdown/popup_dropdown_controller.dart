import 'package:food_quest/core/model/ui/popup_dropdown_model.dart';
import 'package:get/get.dart';

class PopupDropdownController extends GetxController {
  PopupDropdownController(
      {required this.listItem, PopupDropdownModel? selectedItem})
      : selectedItem = (selectedItem ?? listItem.first).obs;

  final Rx<PopupDropdownModel> selectedItem;
  final RxList<PopupDropdownModel> listItem;

  void selectItem(PopupDropdownModel value) {
    selectedItem.value = value;
  }

  @override
  void onClose() {
    selectedItem.close();
    listItem.close();
    super.onClose();
  }
}
