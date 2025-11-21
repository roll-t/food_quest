import 'package:flutter/material.dart';
import 'package:food_quest/core/model/ui/item_model.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/body_bottom_sheet_default.dart';
import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  final RxList<ItemModel> items;
  final bool hasSearch;
  final double? height;
  late RxList<ItemModel> filteredList;
  Rx<ItemModel> selectedItem;
  late TextEditingController searchController;
  final Widget? body;
  BottomSheetController({
    required this.items,
    ItemModel? selectedItem,
    this.height,
    this.hasSearch = true,
    this.body,
  }) : selectedItem = (selectedItem ?? ItemModel()).obs {
    filteredList = RxList<ItemModel>(items);
    searchController = TextEditingController();
  }

  /// Chọn một item
  void selectItem(ItemModel item) {
    selectedItem.value = item;
  }

  void clearSelection() {
    selectedItem.value = ItemModel(title: "");
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredList.value = items;
    } else {
      filteredList.value = items
          .where(
            (item) => (item.title ?? "").toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  void show({
    required String title,
    Function(ItemModel item)? onSelected,
  }) {
    Get.bottomSheet(
      BodyBottomSheetDefault(
        height: height,
        title: title,
        onSelected: (ItemModel item) {
          selectItem(item);
          onSelected?.call(item);
        },
        hasSearch: hasSearch,
        items: items,
        selectedItem: selectedItem.value,
      ),
      isScrollControlled: true,
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
