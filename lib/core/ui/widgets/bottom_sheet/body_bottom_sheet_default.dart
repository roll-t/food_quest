import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/extension/core/empty_extensions.dart';
import 'package:food_quest/core/model/ui/item_model.dart';
import 'package:food_quest/core/ui/widgets/inputs/search_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:get/get.dart';

class BodyBottomSheetDefault extends StatelessWidget {
  final String title;
  final List<ItemModel> items;
  final VoidCallback? onAdd;
  final ItemModel? selectedItem;
  final void Function(ItemModel item) onSelected;
  final double? height;
  final bool hasSearch;
  final RxList<ItemModel> filteredItems = <ItemModel>[].obs;
  final Widget Function(List<ItemModel>)? body;

  BodyBottomSheetDefault({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    this.height,
    this.onAdd,
    this.selectedItem,
    this.body,
    this.hasSearch = true,
  }) {
    filteredItems.assignAll(items);
  }

  static void show({
    required String title,
    required List<ItemModel> items,
    required void Function(ItemModel item) onSelected,
    VoidCallback? onAdd,
    ItemModel? itemSelected,
  }) {
    Get.bottomSheet(
      BodyBottomSheetDefault(
        title: title,
        items: items,
        onSelected: onSelected,
        onAdd: onAdd,
        selectedItem: itemSelected,
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
              child: body != null
                  ? body!(items)
                  : Obx(() {
                      final list = filteredItems;
                      return _buildList(list); // default ListView/Grid
                    }),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------- LIST ---------------------------
  Widget _buildList(List<ItemModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final bool isSelected = item.id == selectedItem?.id;

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
