import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/ui/widgets/buttons/index.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:food_quest/core/utils/custom_state.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:get/get.dart';

class AddFoodPage extends CustomState {
  const AddFoodPage({super.key});

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();

  @override
  String? get title => "Thêm món mới";

  @override
  bool get backgroundImage => true;
}

class _BodyBuilder extends GetView<FoodController> {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppEdgeInsets.all16,
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
          spacing: 16,
          children: [
            CustomTextField(
              controller: controller.userNameController,
              label: "Nhập tên món",
            ),
            PrimaryButton(
              text: "Thêm",
              onPressed: () {},
              isMaxParent: true,
            ),
          ],
        ),
      ),
    );
  }
}
