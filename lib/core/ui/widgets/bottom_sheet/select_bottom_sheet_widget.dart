import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/extension/core/empty_extensions.dart';
import 'package:food_quest/core/model/ui/item_model.dart';
import 'package:food_quest/core/ui/animations/scale_on_tap.dart';
import 'package:food_quest/core/ui/widgets/inputs/search_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:get/get.dart';

enum BottomSheetDisplayType { list, grid }

class SelectBottomSheet extends StatelessWidget {
  final String title;
  final List<ItemModel> items;
  final VoidCallback? onAdd;
  final ItemModel? itemSelected;
  final void Function(ItemModel item) onSelected;
  final double? height;
  final bool hasSearch;
  final BottomSheetDisplayType displayType;

  /// giữ nguyên nhưng tối ưu
  final RxList<ItemModel> filteredItems = <ItemModel>[].obs;

  SelectBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    this.height,
    this.onAdd,
    this.itemSelected,
    this.hasSearch = true,
    this.displayType = BottomSheetDisplayType.list,
  }) {
    filteredItems.assignAll(items);
  }

  static void show({
    required String title,
    required List<ItemModel> items,
    required void Function(ItemModel item) onSelected,
    BottomSheetDisplayType displayType = BottomSheetDisplayType.list,
    VoidCallback? onAdd,
    ItemModel? itemSelected,
  }) {
    Get.bottomSheet(
      SelectBottomSheet(
        title: title,
        items: items,
        onSelected: onSelected,
        displayType: displayType,
        onAdd: onAdd,
        itemSelected: itemSelected,
      ),
    );
  }

  // --------------------------- SEARCH OPTIMIZED ---------------------------
  void _onSearchChanged(String value) {
    final query = removeDiacritics(value.trim().toLowerCase());

    if (query.isEmpty) {
      filteredItems.assignAll(items);
      return;
    }

    filteredItems.assignAll(
      items.where(
        (item) => removeDiacritics((item.title ?? '').toLowerCase()).contains(query),
      ),
    );
  }

  // --------------------------- BUILD ---------------------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasSearch ? KeyboardUtils.hiddenKeyboard : null,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * .6,
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: TextWidget(
                text: title,
                textStyle: AppTextStyle.medium16,
              ),
            ),
            const SizedBox(height: 15),
            if (hasSearch) ...[
              SearchWidget(
                height: 45,
                onSearch: _onSearchChanged,
              ),
              const SizedBox(height: 25),
            ],
            Expanded(
              child: Obx(() {
                final list = filteredItems;
                return displayType == BottomSheetDisplayType.grid ? _buildGrid(list) : _buildList(list);
              }),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------- GRID ---------------------------
  Widget _buildGrid(List<ItemModel> list) {
    return GridView.builder(
      itemCount: list.length + (onAdd != null ? 1 : 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        // nút thêm
        if (onAdd != null && index == 0) {
          return ScaleOnTap(
            onTap: onAdd,
            child: Container(
              margin: AppEdgeInsets.all8,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppThemeColors.primary.withValues(alpha: .5),
              ),
              child: AppIcons.icAdd.show(),
            ),
          );
        }

        final item = list[onAdd != null ? index - 1 : index];
        final isSelected = item.id == itemSelected?.id;

        return GestureDetector(
          onTap: () {
            onSelected(item);
            Get.back();
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected
                  ? AppThemeColors.primary.withOpacity(0.15)
                  : AppThemeColors.background200.withOpacity(0.08),
              border: Border.all(
                color: isSelected ? AppThemeColors.primary : AppColors.transparent,
                width: 1.5,
              ),
            ),
            child: TextWidget(
              text: item.title.orNA(),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        );
      },
    );
  }

  // --------------------------- LIST ---------------------------
  Widget _buildList(List<ItemModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final bool isSelected = item.id == itemSelected?.id;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? AppThemeColors.primary.withOpacity(0.15) : null,
          ),
          child: ListTile(
            title: TextWidget(text: item.title.orNA()),
            onTap: () {
              onSelected(item);
              Get.back();
            },
          ),
        );
      },
    );
  }
}
