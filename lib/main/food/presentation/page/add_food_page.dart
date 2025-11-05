import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/core/ui/animations/scale_on_tap.dart';
import 'package:food_quest/core/ui/widgets/buttons/primary_button.dart';
import 'package:food_quest/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:food_quest/core/ui/widgets/shimmer/shimmer_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/custom_state.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/presentation/controller/deep_link_controller.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/home/feature/presentation/widgets/food_item.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        spacing: 16,
        children: [
          ///---> [ADD FORM]
          _BuildAddFoodWidget(),

          ///---> [LIST]
          _BuildListRecommend()
        ],
      ),
    );
  }
}

class _BuildListRecommend extends StatelessWidget {
  const _BuildListRecommend();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
        ),
        child: Column(
          spacing: 16,
          children: [
            SizedBox(
              height: 35,
              child: GetBuilder<FoodController>(
                id: "HANDLE_BAR_ID",
                builder: (controller) {
                  ///---> [SEARCH CASE]
                  return Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(text: "Món đã lưu"),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          child: controller.isMultiSelectMode.value
                              ? Row(
                                  spacing: 16,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ScaleOnTap(
                                      onTap: controller.onSelectMultiChoiceFood,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppThemeColors.primary.withValues(alpha: .2),
                                        ),
                                        child: Row(
                                          spacing: 6,
                                          children: [
                                            const TextWidget(text: "Thêm"),
                                            AppIcons.icAdd.show(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ScaleOnTap(
                                      onTap: controller.deleteMultiSelectedFoods,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppThemeColors.primary.withValues(alpha: .2),
                                        ),
                                        child: Row(
                                          spacing: 6,
                                          children: [
                                            const TextWidget(text: "Xóa"),
                                            AppIcons.icDelete.show(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const CustomTextField(
                                  height: 35,
                                  hintText: "Nhập tên món...",
                                ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            GetBuilder<FoodController>(
              id: "LIST_FOOD_RECOMMEND_ID",
              builder: (controller) {
                if (controller.isLoadingListSaved.value) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: AppEdgeInsets.all6,
                          child: const ShimmerWidget(radius: 16),
                        );
                      },
                    ),
                  );
                }
                if (controller.listFoods.isEmpty) {
                  return Expanded(
                    child: Opacity(
                      opacity: .3,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 16,
                          children: [
                            AppIcons.icEmptyData.show(size: 40.w),
                            const TextWidget(
                              text: "không có dữ liệu",
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.resetData,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemCount: controller.listFoods.length,
                      itemBuilder: (context, index) {
                        final food = controller.listFoods[index];
                        return _FoodSelectableItem(food: food);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildAddFoodWidget extends StatelessWidget {
  const _BuildAddFoodWidget();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodController>(
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
            spacing: 8,
            children: [
              CustomTextField(
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12)
                                            .copyWith(left: 8.0, right: 12.0),
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
              const SizedBox.shrink(),
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

class _FoodSelectableItem extends GetView<FoodController> {
  final FoodModel food;
  const _FoodSelectableItem({required this.food});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isSelected = controller.selectedFoodsHandler.contains(food);
      final bool isSelectedMarker = controller.selectedFoodsMarker.any((e) => e.id == food.id);

      return GestureDetector(
        onLongPress: () {
          if (isSelectedMarker) return;
          controller.enableMultiSelect();
          controller.toggleFoodSelection(food);
        },
        onTap: () {
          if (isSelectedMarker && controller.isMultiSelectMode.value) return;
          if (controller.isMultiSelectMode.value) {
            controller.toggleFoodSelection(food);
          } else {
            if (food.metaDataModel?.url != null) {
              Utils.lanchUrl(food.metaDataModel!.url);
            }
          }
        },
        child: Stack(
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 200),
              tween: Tween(begin: 1, end: isSelected ? .85 : 1),
              curve: Curves.easeOut,
              builder: (_, scale, child) => Transform.scale(
                scale: scale,
                child: child,
              ),
              child: FoodItem(food: food),
            ),
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1 : 0,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 4,
                      color: AppThemeColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: isSelected ? 6 : -20,
              right: isSelected ? 6 : -20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1 : 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: AppThemeColors.primary,
                    ),
                  ),
                  child: AppIcons.icTick.show(),
                ),
              ),
            ),
            if (isSelectedMarker)
              Positioned.fill(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        margin: AppEdgeInsets.all6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.black.withValues(
                            alpha: .2,
                          ),
                        ),
                        child: const SizedBox.shrink(),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.background2,
                        ),
                        child: Row(
                          children: [
                            const TextWidget(
                              text: "Đã chọn",
                              color: AppColors.white,
                            ),
                            AppIcons.icWheelMark.show(size: 35),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}
