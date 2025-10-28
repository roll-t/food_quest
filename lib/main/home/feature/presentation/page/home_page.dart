import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_images.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/images/asset_image_widget.dart';
import 'package:food_quest/main/home/feature/presentation/controller/home_controller.dart';
import 'package:get/get.dart';

// NAV Home
// =========================== //
//       MAIN HOME VIEW        //
// =========================== //
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends GetView<HomeController> {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Row(
          children: [
            AssetImageWidget(
              assetPath: AppImages.iLogo,
              width: 100,
            )
          ],
        ),
        Container(
          color: AppThemeColors.background300,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              // WheelSpinner(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
