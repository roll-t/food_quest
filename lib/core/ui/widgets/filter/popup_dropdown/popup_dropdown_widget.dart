import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/model/ui/popup_dropdown_model.dart';
import 'package:food_quest/core/ui/widgets/filter/popup_dropdown/popup_dropdown_controller.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPopupDropdown extends StatelessWidget {
  final PopupDropdownController controller;

  /// Context để hiển thị popup. Nếu không truyền sẽ dùng context hiện tại.
  final BuildContext? popupContext;

  final Function(PopupDropdownModel value)? onSelected;

  const CustomPopupDropdown({
    super.key,
    required this.controller,
    this.popupContext,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        KeyboardUtils.hiddenKeyboard();
        _showPopupMenu(popupContext ?? context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: AppThemeColors.background100,
          border: Border.all(width: 0.5, color: AppColors.text400),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => TextWidget(
                    text: controller.selectedItem.value.label,
                    textStyle: AppTextStyle.semiBold14,
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: AppThemeColors.primary,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) async {
    // Tìm vị trí widget trên màn hình
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    // Hiển thị popup ngay bên dưới
    final selected = await showMenu<PopupDropdownModel>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 5,
        offset.dx + size.width,
        offset.dy,
      ),
      items: controller.listItem
          .map(
            (item) => PopupMenuItem<PopupDropdownModel>(
              value: item,
              child: TextWidget(text: item.label),
            ),
          )
          .toList(),
    );

    if (selected != null) {
      controller.selectItem(selected);
      if (onSelected != null) {
        onSelected!(selected);
      }
    }
  }
}
