import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_vectors.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onChange;
  final Color selectedItemColor;

  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onChange,
    required this.selectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      onTap: onChange,
      backgroundColor: AppThemeColors.background300,
      color: AppThemeColors.primary,
      buttonBackgroundColor: selectedItemColor,
      height: 60,
      animationDuration: const Duration(milliseconds: 200),
      items: [
        AppVectors.icHome.show(
          size: 25,
          color: AppColors.white,
        ),
        AppVectors.icSetting.show(
          size: 25,
          color: AppColors.white,
        )
      ],
    );
  }
}
