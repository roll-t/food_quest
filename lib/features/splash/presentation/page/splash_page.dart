import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_images.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/images/asset_image_widget.dart';
import 'package:food_quest/features/splash/presentation/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColors.dark700,
      body: const Center(
        child: AssetImageWidget(assetPath: AppImages.iLogo),
      ),
    );
  }
}
