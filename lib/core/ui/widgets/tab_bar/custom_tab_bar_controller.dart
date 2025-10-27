import 'package:food_quest/core/model/ui/item_model.dart';
import 'package:get/get.dart';

class TabBarController {
  TabBarController({
    required this.tabs,
  });
  final List<ItemModel> tabs;
  RxInt selectedIndex = 0.obs;

  void onChangeTab(int index) {
    selectedIndex.value = index;
  }
}
