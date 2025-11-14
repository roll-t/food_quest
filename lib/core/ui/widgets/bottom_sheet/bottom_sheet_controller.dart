import 'package:flutter/material.dart';
import 'package:food_quest/core/model/ui/item_model.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/select_bottom_sheet_widget.dart';
import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  final RxList<ItemModel> listItem;
  final bool hasSearch;
  final double? height;
  final BottomSheetDisplayType displayType;
  final VoidCallback? onAdd;
  late RxList<ItemModel> filteredList;
  Rx<ItemModel> itemSelected;
  late TextEditingController searchController;

  BottomSheetController({
    required this.listItem,
    ItemModel? itemSelected,
    this.height,
    this.onAdd,
    this.displayType = BottomSheetDisplayType.list,
    this.hasSearch = true,
  }) : itemSelected = (itemSelected ?? ItemModel()).obs {
    filteredList = RxList<ItemModel>(listItem);
    searchController = TextEditingController();
  }

  /// Chọn một item
  void selectItem(ItemModel item) {
    itemSelected.value = item;
  }

  void clearSelection() {
    itemSelected.value = ItemModel(title: "");
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredList.value = listItem;
    } else {
      filteredList.value = listItem
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
      SelectBottomSheet(
        height: height,
        title: title,
        onAdd: onAdd,
        displayType: displayType,
        onSelected: (ItemModel item) {
          selectItem(item);
          onSelected?.call(item);
        },
        hasSearch: hasSearch,
        items: listItem,
        itemSelected: itemSelected.value,
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
