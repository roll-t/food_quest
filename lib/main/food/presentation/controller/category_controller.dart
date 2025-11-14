import 'package:food_quest/core/model/ui/item_model.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/select_bottom_sheet_widget.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  /// BottomSheet controller
  final BottomSheetController categorySheetController = BottomSheetController(
    hasSearch: false,
    height: Get.height * .85,
    displayType: BottomSheetDisplayType.grid,
    onAdd: () {},
    itemSelected: ItemModel(id: "select", title: "Chọn danh mục"),
    listItem: <ItemModel>[].obs,
  );

  /// Internal storage for categories
  final RxList<ItemModel> _categories = <ItemModel>[].obs;

  List<ItemModel> get categories => _categories;

  /// ---------------- CRUD ----------------

  /// 🔹 Thêm danh mục mới
  void addCategory(String title) {
    final newItem = ItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );
    _categories.add(newItem);
    categorySheetController.listItem.add(newItem);
  }

// Cập nhật danh mục
  void updateCategory(String id, String newTitle) {
    final index = _categories.indexWhere((e) => e.id == id);
    if (index != -1) {
      _categories[index] = ItemModel(id: _categories[index].id, title: newTitle);
      final sheetIndex = categorySheetController.listItem.indexWhere((e) => e.id == id);
      if (sheetIndex != -1) {
        categorySheetController.listItem[sheetIndex] =
            ItemModel(id: categorySheetController.listItem[sheetIndex].id, title: newTitle);
      }
    }
  }

  /// 🔹 Xóa danh mục
  void deleteCategory(String id) {
    _categories.removeWhere((e) => e.id == id);
    categorySheetController.listItem.removeWhere((e) => e.id == id);
  }

  /// 🔹 Chọn danh mục
  void selectCategory(ItemModel item) {
    categorySheetController.itemSelected.value = item;
  }

  /// 🔹 Mở BottomSheet để chọn danh mục
  void openCategorySheet() {
    SelectBottomSheet.show(
      title: "Chọn danh mục",
      items: categorySheetController.listItem,
      onSelected: selectCategory,
      displayType: categorySheetController.displayType,
    );
  }

  /// ---------------- Init sample ----------------
  void initSample() {
    final sample = [
      ItemModel(id: "1", title: "Món ăn"),
      ItemModel(id: "2", title: "Tráng miệng"),
      ItemModel(id: "3", title: "Đồ uống"),
    ];
    _categories.assignAll(sample);
    categorySheetController.listItem.assignAll(sample);
  }
}
