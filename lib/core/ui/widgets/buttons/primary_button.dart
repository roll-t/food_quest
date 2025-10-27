import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final double textSize;
  final VoidCallback onPressed;
  final bool isMaxParent;
  final Color? backgroundColor;

  const PrimaryButton({
    required this.text,
    this.textSize = 14,
    required this.onPressed,
    this.backgroundColor,
    this.isMaxParent = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ?? AppThemeColors.primary;
    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: TextWidget(
        text: text,
        fontWeight: FontWeight.bold,
        size: textSize,
        color: AppColors.white,
      ),
    );

    return isMaxParent
        ? ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: button,
          )
        : button;
  }
}
