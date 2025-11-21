import 'package:flutter/material.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/custom_bottom_sheet_input.dart';
import 'package:food_quest/features/category/application/controller/category_controller.dart';
import 'package:food_quest/features/category/application/state/id_category_builder.dart';
import 'package:get/get.dart';

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      id: IdCategoryBuilder.ADD_CATEGORY_ID,
      builder: (controller) {
        return CustomBottomSheetInput(
          label: "Chọn danh mục",
          height: 40,
          onSelectedItem: (_) {},
          controller: controller.categorySheetController,
          titleBottomSheet: "Danh sách danh mục",
        );
      },
    );
  }
}
