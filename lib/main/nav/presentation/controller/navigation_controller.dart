import 'package:food_quest/main/nav/di/manage_section_binding.dart';
import 'package:food_quest/main/nav/di/profile_section_binding%20.dart';
import 'package:food_quest/main/nav/presentation/section/manage_section.dart';
import 'package:food_quest/main/nav/presentation/section/profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt currentPage = 0.obs;

  List<String> routeNames = [
    const ManageSection().routeName,
    const ProfileSection().routeName,
  ];

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/manage-section':
        return GetPageRoute(
          settings: settings,
          page: () => const ManageSection(),
          transition: Transition.fadeIn,
          binding:ManageSectionBinding(),
        );
      case '/profile-section':
        return GetPageRoute(
          settings: settings,
          page: () => const ProfileSection(),
          binding: ProfileSectionBinding(),
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
