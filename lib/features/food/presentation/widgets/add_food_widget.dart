import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/core/ui/widgets/buttons/primary_button.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/features/category/presentation/widget/select_category_widget.dart';
import 'package:food_quest/features/food/application/controller/add_from_deep_link_controller.dart';
import 'package:food_quest/features/food/application/controller/deep_link_controller.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddFoodWidget extends StatelessWidget {
  const AddFoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFromDeepLinkController>(
      builder: (controller) {
        return Container(
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
              const SelectCategoryWidget(),
              CustomTextField(
                height: 40,
                controller: controller.foodNameController,
                label: "Nhập tên ghi nhớ",
              ),
              if (DeepLinkService.isOpenedFromShare)
                GetBuilder<DeepLinkController>(
                  id: "EXTRA_LINK_ID",
                  builder: (controller) {
                    ///---> [LOADING_CASE]
                    if (controller.isLoading.value) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const SizedBox(
                          height: 70,
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 1.5),
                          ),
                        ),
                      );
                    }

                    ///---> [EMPTY_CASE]
                    final data = controller.metaData.value;

                    if (data == null) {
                      return const TextWidget(text: "⚠ Không có dữ liệu deep link");
                    }

                    ///---> [RENDER_CASE]
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.0,
                      children: [
                        if (data.url.isNotEmpty)
                          TextWidget(
                            text: data.url,
                            color: AppColors.blue,
                          ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppThemeColors.primary,
                              width: 1.0,
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (data.imageUrl.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    child: ColoredBox(
                                      color: AppColors.accent,
                                      child: CachedNetworkImage(
                                        imageUrl: data.imageUrl,
                                        width: 90,
                                        height: 70,
                                        fit: BoxFit.cover,
                                        placeholder: (context, _) => Container(
                                          width: 90,
                                          height: 70,
                                          color: Colors.grey.shade200,
                                          alignment: Alignment.center,
                                          child: const CircularProgressIndicator(strokeWidth: 1.5),
                                        ),
                                        errorWidget: (context, _, __) => Container(
                                          width: 90,
                                          height: 70,
                                          color: Colors.grey.shade300,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.broken_image,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12).copyWith(
                                      left: 8.0,
                                      right: 12.0,
                                    ),
                                    child: Column(
                                      spacing: 4.0,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (data.title.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4),
                                            child: TextWidget(
                                              text: data.title,
                                              size: 12,
                                              maxLines: 2,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        TextWidget(
                                          text: data.description,
                                          fontWeight: FontWeight.w400,
                                          size: 12,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              PrimaryButton(
                isMaxParent: true,
                text: "✔ Xác nhận & thêm vào danh sách",
                onPressed: controller.addFood,
              ),
            ],
          ),
        );
      },
    );
  }
}
