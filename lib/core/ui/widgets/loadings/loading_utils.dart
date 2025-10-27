import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingUtils {
  /// Hiển thị overlay loading cho bất kỳ asyncFunction nào
  static Future<void> showOverlayLoading({
    required AsyncCallback asyncFunction,
    Widget? customWidget,
  }) {
    return Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget:
          customWidget ??
          Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              size: 10.w,
              color: AppThemeColors.primary,
            ),
          ),
    );
  }
}
