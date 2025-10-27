import 'package:food_quest/core/config/const/app_vectors.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/model/ui/item_model.dart';
import 'package:food_quest/core/extension/core/empty_extensions.dart';
import 'package:food_quest/core/extension/core/rx_extensions.dart';
import 'package:food_quest/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:food_quest/core/ui/widgets/texts/text_span_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final BottomSheetController controller;
  final String? titleBottomSheet;
  final Color? backgroundColor;
  final List<BoxShadow>? shadow;
  final double borderRadius;
  final double height;
  final EdgeInsets padding;
  final String hint;
  final String? label;
  final Function(ItemModel) onSelectedItem;
  final bool isMaxParent;
  final String? leadingIconUrl;
  final bool isRequired;
  const CustomBottomSheetWidget({
    super.key,
    required this.onSelectedItem,
    required this.controller,
    this.backgroundColor,
    this.shadow,
    this.leadingIconUrl,
    this.isMaxParent = true,
    this.borderRadius = 6,
    this.height = 35,
    this.padding = const EdgeInsets.only(left: 6, right: 5),
    this.hint = "",
    this.isRequired = false,
    this.label,
    this.titleBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          TextSpanWidget(
              size: 14,
              fontWeight1: FontWeight.w600,
              fontWeight2: FontWeight.w600,
              textColor1: AppThemeColors.text,
              textColor2: AppColors.red,
              text1: label.orNA(),
              text2: isRequired ? "*" : ""),
          const SizedBox(height: 6),
        ],
        GestureDetector(
          onTap: () {
            KeyboardUtils.hiddenKeyboard();
            controller.show(
              title: titleBottomSheet.orNA(),
              onSelected: onSelectedItem,
            );
          },
          child: Container(
            padding: padding,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppThemeColors.background100,
              border: Border.all(
                width: .5,
                color: const Color.fromRGBO(189, 189, 189, 1),
              ),
            ),
            child: controller.itemSelected.obx(
              onData: (value) {
                return Row(
                  children: [
                    if (leadingIconUrl.isNotNullOrEmpty) ...[
                      Utils.iconSvg(
                        svgUrl: leadingIconUrl.orIcNull(),
                        color: AppColors.text300,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                    ],
                    const SizedBox(width: 4),
                    Expanded(
                      child: TextWidget(
                        text: value.title.orEmpty().isNotEmpty
                            ? value.title.orNA()
                            : hint,
                        size: 14,
                        color: value.title.orEmpty().isNotEmpty
                            ? AppThemeColors.text
                            : AppColors.grey,
                        fontWeight: value.title.orEmpty().isNotEmpty
                            ? FontWeight.w500
                            : FontWeight.w400,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Utils.iconSvg(
                      svgUrl: AppVectors.icArrowDown,
                      color: AppThemeColors.text100,
                      size: 18,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );

    return isMaxParent
        ? SizedBox(width: double.infinity, child: content)
        : Align(
            alignment: Alignment.centerLeft,
            child: IntrinsicWidth(child: content));
  }
}
