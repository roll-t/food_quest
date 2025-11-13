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

class SelectBottomSheet extends StatelessWidget {
  final String title;
  final List<ItemModel> items;
  final ItemModel? itemSelected;
  final void Function(ItemModel item) onSelected;
  final double? height;
  final bool hasSearch;

  /// Dùng để filter dữ liệu cục bộ
  final RxList<ItemModel> filteredItems = <ItemModel>[].obs;

  SelectBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    this.height,
    this.itemSelected,
    this.hasSearch = true,
  }) {
    filteredItems.assignAll(items);
  }

  static void show({
    required String title,
    required List<ItemModel> items,
    required void Function(ItemModel item) onSelected,
  }) {
    Get.bottomSheet(
      SelectBottomSheet(
        title: title,
        items: items,
        onSelected: onSelected,
      ),
    );
  }

  void _onSearchChanged(String value) {
    final query = _normalize(value.trim());

    if (query.isEmpty) {
      filteredItems.assignAll(items);
    } else {
      filteredItems.assignAll(
        items.where(
          (item) {
            final title = _normalize(item.title ?? '');
            return title.contains(query);
          },
        ),
      );
    }
  }

  String _normalize(String input) {
    return removeDiacritics(input).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasSearch ? KeyboardUtils.hiddenKeyboard : null,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * .6,
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
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
                if (filteredItems.isEmpty) {
                  return const Center(
                    child: TextWidget(text: "Không tìm thấy kết quả"),
                  );
                }
                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    final RxBool isSelected = (item.id == itemSelected?.id).obs;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isSelected.value ? AppThemeColors.primary.withValues(alpha: 0.15) : null,
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
