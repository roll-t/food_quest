import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/utils/utils.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final bool isActive;
  final String svgUrl;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  const CircleIconButton({
    super.key,
    this.isActive = false,
    required this.svgUrl,
    required this.onTap,
    this.size = 30,
    this.iconSize = 20,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ??
              (!isActive
                  ? AppThemeColors.light100.withValues(alpha: 0.5)
                  : AppThemeColors.light100),
        ),
        child: Center(
          child: Utils.iconSvg(
            svgUrl: svgUrl,
            size: iconSize,
            color: iconColor ?? AppThemeColors.primary,
          ),
        ),
      ),
    );
  }
}
