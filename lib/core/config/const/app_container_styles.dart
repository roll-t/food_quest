import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:flutter/widgets.dart';

class AppContainerStyles {
  static BoxDecoration cardStyle() {
    return BoxDecoration(
      color: AppThemeColors.background100,
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          offset: const Offset(1, 1),
          blurRadius: 4,
          spreadRadius: 2,
          color: AppColors.neutralColor2.withValues(alpha: .1),
        ),
      ],
    );
  }

  static BoxDecoration card100() {
    return BoxDecoration(
      color: AppThemeColors.background100,
      borderRadius: BorderRadius.circular(6.0),
    );
  }

  static BoxDecoration card200() {
    return BoxDecoration(
      color: AppThemeColors.background100,
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  static List<BoxShadow> cardShadow() {
    return [
      BoxShadow(
        offset: const Offset(1, 1),
        blurRadius: 4,
        spreadRadius: 1,
        color: AppColors.shadow700.withValues(alpha: .08),
      ),
      BoxShadow(
        offset: const Offset(0, 0),
        blurRadius: 2,
        spreadRadius: 0,
        color: AppColors.shadow700.withValues(alpha: .1),
      ),
    ];
  }
}
