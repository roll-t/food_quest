import 'package:flutter/material.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:food_quest/main/food/presentation/controller/category_controller.dart';
import 'package:get/get.dart';

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        return CustomBottomSheetWidget(
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
