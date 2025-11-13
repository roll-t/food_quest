import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/const/app_vectors.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/animations/scale_on_tap.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/core/ui/widgets/shimmer/shimmer_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/custom_state.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:food_quest/main/food/data/model/food_model.dart';
import 'package:food_quest/main/food/di/add_from_deep_link_binding.dart';
import 'package:food_quest/main/food/presentation/controller/food_controller.dart';
import 'package:food_quest/main/food/presentation/widgets/add_food_widget.dart';
import 'package:food_quest/main/food/presentation/widgets/food_detail_widget.dart';
import 'package:food_quest/main/food/presentation/widgets/marker_items.dart';
import 'package:food_quest/main/home/presentation/widgets/food_item.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddFoodPage extends CustomState {
  const AddFoodPage({super.key});

  @override
  bool get dismissKeyboard => true;

  @override
  bool get safeTop => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BuildActionItemAppBar extends StatelessWidget {
  const _BuildActionItemAppBar();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DialogUtils.show(
          binding: AddFromDeepLinkBinding(),
          Material(
            color: Colors.transparent,
            child: Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 90.w,
                        padding: AppEdgeInsets.all12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: AddFoodWidget(),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: AppIcons.icClose.show(
                      padding: AppEdgeInsets.all8,
                      onTap: () => Get.back(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: AppEdgeInsets.all4,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: AppIcons.icAdd.show(),
      ),
    );
  }
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: Column(
        spacing: 8,
        children: [
          SizedBox(
            height: 35,
            child: GetBuilder<FoodController>(
              id: "HANDLE_BAR_ID",
              builder: (controller) {
                return Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppVectors.icArrowBack.show(
                      onTap: () => Get.back(),
                      color: AppThemeColors.text,
                    ),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        child: controller.isMultiSelectMode.value
                            ? Row(
                                spacing: 16,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  ScaleOnTap(
                                    onTap: controller.resetSettings,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppThemeColors.primary.withValues(alpha: .2),
                                      ),
                                      child: Row(
                                        spacing: 4,
                                        children: [
                                          Obx(
                                            () => TextWidget(
                                              text: controller.selectedFoodsHandler.length.toString(),
                                            ),
                                          ),
                                          AppIcons.icClose.show(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomBottomSheetWidget(
                                    backgroundColor: AppThemeColors.primary,
                                    onSelectedItem: (_) {},
                                    controller: controller.typeSort,
                                    titleBottomSheet: "Danh sách",
                                    borderRadius: 300,
                                    isMaxParent: false,
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const _BuildActionItemAppBar(),
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
    );
  }
}

class _FoodSelectableItem extends GetView<FoodController> {
  final FoodModel food;
  const _FoodSelectableItem({required this.food});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final bool isSelected = controller.selectedFoodsHandler.contains(food);
        final bool isSelectedMarker = controller.selectedFoodsMarker.any((e) => e.id == food.id);
        return GestureDetector(
          onLongPress: () {
            if (isSelectedMarker) return;
            controller.enableMultiSelect();
            controller.toggleFoodSelection(food);
          },
          onTap: () async {
            if (isSelectedMarker && controller.isMultiSelectMode.value) return;
            if (controller.isMultiSelectMode.value) {
              controller.toggleFoodSelection(food);
            } else {
              bool hasThumbnail = await Utils.isValidImageUrl(food.metaDataModel?.imageUrl);
              if (food.metaDataModel?.url != null) {
                Get.dialog(
                  FoodDetailWidget(
                    food: food,
                    hasThumbnail: hasThumbnail,
                  ),
                );
              }
            }
          },
          child: Stack(
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 200),
                tween: Tween(begin: 1, end: isSelected ? .9 : 1),
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
                    margin: const EdgeInsets.all(4),
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
                top: isSelected ? 0 : -15,
                right: isSelected ? 0 : -15,
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
              MarkerItems(
                isInWheel: (isSelectedMarker),
                icons: [
                  if (food.metaDataModel?.url.isNotEmpty ?? false)
                    Utils.getSocialIcon(urlSocial: food.metaDataModel?.url) ?? const SizedBox.shrink(),
                  if ((isSelectedMarker)) AppIcons.icWheelMark.show(size: 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
