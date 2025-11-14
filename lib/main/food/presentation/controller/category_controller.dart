import 'package:flutter/material.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/model/ui/item_model.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/select_bottom_sheet_widget.dart';
import 'package:food_quest/core/ui/widgets/buttons/index.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/main/food/data/model/category_model.dart';
import 'package:food_quest/main/food/data/source/category_service.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryController extends GetxController {
  final CategoryService _service = CategoryService();

  /// BottomSheet
  final BottomSheetController categorySheetController = BottomSheetController(
    hasSearch: false,
    height: Get.height * .85,
    displayType: BottomSheetDisplayType.grid,
    onAdd: _showAddDialog,
    itemSelected: ItemModel(id: "select", title: "Chọn danh mục"),
    listItem: <ItemModel>[].obs,
  );

  /// Firestore data
  final RxList<CategoryModel> _categories = <CategoryModel>[].obs;
  List<CategoryModel> get categories => _categories;

  List<ItemModel> get itemModels => _categories.map((c) => ItemModel(id: c.id ?? "", title: c.name)).toList();

  @override
  void onInit() {
    super.onInit();
    _service.streamCategories().listen((data) {
      _categories.assignAll(data);
      _syncToSheet();
    });
  }

  /// Sync list for BottomSheet
  void _syncToSheet() {
    categorySheetController.listItem.assignAll(itemModels);
    categorySheetController.listItem.refresh();
  }

  /// Select category
  void selectCategory(ItemModel item) {
    categorySheetController.itemSelected.value = item;
  }

  /// ---------------- ADD CATEGORY ----------------
  Future<void> createCategory(String name) async {
    if (name.trim().isEmpty) return;

    Utils.runWithLoading(() async {
      final model = CategoryModel(name: name);
      final success = await _service.addCategory(model);

      if (success) {
        Get.back(); // đóng dialog
      } else {
        Get.snackbar("Lỗi", "Không thêm được danh mục");
      }
    });
  }

  /// ---------------- UI Dialog ----------------
  static void _showAddDialog() {
    final controller = Get.find<CategoryController>();
    final TextEditingController textCtrl = TextEditingController();

    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 90.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                CustomTextField(
                  controller: textCtrl,
                  label: "Tên danh mục",
                ),
                PrimaryButton(
                  isMaxParent: true,
                  text: "Thêm danh mục",
                  onPressed: () {
                    controller.createCategory(textCtrl.text);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
