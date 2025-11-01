import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/ui/animations/scale_on_tap.dart';
import 'package:food_quest/core/ui/widgets/buttons/index.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/custom_state.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/home/feature/presentation/widgets/food_item.dart';
import 'package:get/get.dart';

class AddFoodPage extends CustomState {
  const AddFoodPage({super.key});

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();

  @override
  String? get title => "Thêm món mới";

  @override
  bool get dismissKeyboard => true;

  @override
  bool get backgroundImage => true;
}

class _BodyBuilder extends GetView<FoodController> {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppEdgeInsets.all16,
      child: Column(
        spacing: 16,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
            ),
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: controller.foodNameController,
                  label: "Nhập tên món",
                ),
                PrimaryButton(
                  text: "Thêm",
                  onPressed: controller.addFood,
                  isMaxParent: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                spacing: 16,
                children: [
                  const Row(
                    spacing: 16,
                    children: [
                      TextWidget(text: "Món đã lưu"),
                      Expanded(
                          child: CustomTextField(
                        height: 35,
                        hintText: "Nhập tên món...",
                      )),
                    ],
                  ),
                  Expanded(
                    child: Obx(
                      () => GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                        ),
                        itemCount: controller.listFoodSelected.length,
                        itemBuilder: (BuildContext context, int index) {
                          final FoodModel food = controller.listFoodSelected[index];
                          return ScaleOnTap(
                            onTap: () {},
                            child: FoodItem(
                              food: food,
                              onRemove: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
