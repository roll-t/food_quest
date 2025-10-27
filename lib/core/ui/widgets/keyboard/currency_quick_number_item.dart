import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/extension/core/currency_extensions.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class CurrencyQuickNumberItem extends StatelessWidget {
  final String value;
  final TextEditingController controller;

  const CurrencyQuickNumberItem({
    super.key,
    required this.value,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var data =
            (controller.text.trim().isEmpty) ? "0" : controller.text.trim();
        final newData = data + value.trim();
        final currency = newData.toCurrencyNum();

        if (currency > 0 && currency < 999999999999) {
          final newText = currency.toString().toCurrency().trim();

          controller.value = controller.value.copyWith(
            text: newText,
            // luôn đưa con trỏ về cuối text
            selection: TextSelection.collapsed(offset: newText.length),
            composing: TextRange.empty,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.text200,
        ),
        child: TextWidget(
          text: value,
          textStyle: AppTextStyle.regular18,
        ),
      ),
    );
  }
}
