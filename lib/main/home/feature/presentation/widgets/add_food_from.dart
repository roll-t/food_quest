import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:food_quest/main/home/feature/presentation/controller/add_food_form_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddFoodFrom extends GetView<AddFoodFormController> {
  const AddFoodFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: controller.scaleAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 95.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const _BodyBuilder(),
          ),
        ),
      ),
    );
  }
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: CustomTextField(),
            ),
            AppIcons.icClose.show(
              padding: AppEdgeInsets.all8,
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
        Expanded(
          child: GridView.builder(
            padding: AppEdgeInsets.h16,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: 30,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
        Container(
          margin: AppEdgeInsets.all12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1,
              color: AppThemeColors.primary,
            ),
          ),
          height: 20.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) => Container(
              width: 20.w,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        )
      ],
    );
  }
}
