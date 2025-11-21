import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_quest/features/home/di/home_binding.dart';
import 'package:food_quest/features/home/presentation/page/home_page.dart';
import 'package:food_quest/features/user/features/profile/di/profile_binding%20.dart';
import 'package:food_quest/features/user/features/profile/presentation/page/profile_page.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt currentPage = 0.obs;

  List<String> routeNames = [
    "/home-section",
    '/profile-section',
  ];

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/home-section":
        return GetPageRoute(
          settings: settings,
          page: () => const HomePage(),
          transition: Transition.fadeIn,
          bindings: [
            HomeBinding(),
          ],
        );
      case '/profile-section':
        return GetPageRoute(
          settings: settings,
          page: () => const ProfileSection(),
          binding: ProfileBinding(),
          transition: Transition.fadeIn,
        );
    }
    return null;
  }

  void onChangeItemBottomBar(int index) {
    if (currentPage.value == index) return;
    currentPage.value = index;
    Get.offAndToNamed(routeNames[index], id: 10);
  }
}
