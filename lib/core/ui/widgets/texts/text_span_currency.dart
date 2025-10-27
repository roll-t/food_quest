import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/extension/core/currency_extensions.dart';
import 'package:flutter/material.dart';
import 'text_span_widget.dart'; // nếu bạn dùng TextSpanWidget riêng

class TextSpanCurrency extends StatelessWidget {
  final String label;
  final String value;
  final Color? textColor;
  final bool isCurrency;

  const TextSpanCurrency({
    super.key,
    required this.label,
    required this.value,
    this.textColor,
    this.isCurrency = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue =
        isCurrency ? value.toCurrency(withSymbol: true) : value;

    return TextSpanWidget(
      text1: "$label: ",
      text2: displayValue,
      size: 14,
      textColor1: AppThemeColors.text300,
      textColor2: textColor ?? AppColors.green,
      fontWeight2: FontWeight.bold,
    );
  }
}
