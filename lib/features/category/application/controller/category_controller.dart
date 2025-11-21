import 'package:food_quest/core/model/ui/item_model.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/features/category/data/model/category_model.dart';
import 'package:food_quest/features/category/data/source/category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final CategoryService _service = CategoryService();
  static RxBool isShowAddCategory = false.obs;

  final BottomSheetController categorySheetController = BottomSheetController(
    hasSearch: false,
    height: Get.height * .85,
    selectedItem: ItemModel(
      id: "select",
      title: "Chọn danh mục",
    ),
    items: <ItemModel>[].obs,
  );

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
    categorySheetController.items.assignAll(itemModels);
    categorySheetController.items.refresh();
  }

  /// Select category
  void selectCategory(ItemModel item) {
    categorySheetController.selectedItem.value = item;
  }

  /// ---------------- ADD CATEGORY ----------------
  Future<void> createCategory(String name) async {
    if (name.trim().isEmpty) return;

    Utils.runWithLoading(() async {
      final model = CategoryModel(name: name);
      final success = await _service.addCategory(model);

      if (success) {
        Get.back();
      } else {
        Get.snackbar("Lỗi", "Không thêm được danh mục");
      }
    });
  }
}
