import 'package:flutter/material.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/main/home/feature/presentation/controller/home_controller.dart';
import 'package:food_quest/main/home/feature/presentation/widgets/wheel_spinner.dart';
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
    return Container(
      color: AppThemeColors.background300,
      child: const Stack(
        children: [
          WheelSpinner(),
        ],
      ),
    );
  }
}
