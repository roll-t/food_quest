import 'package:flutter/material.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/extension/core/rx_extensions.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:food_quest/core/utils/get_view/custom_state.dart';
import 'package:food_quest/features/nav/presentation/controller/navigation_controller.dart';
import 'package:food_quest/features/nav/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:get/get.dart';

class NavigationPage extends CustomState {
  const NavigationPage({super.key});

  ///---> [Build-bottom-navigation]
  @override
  Widget? get bottomNavigationBar => const _BuildBottomNavigationBar();

  ///---> [Build-body]
  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final nestedNavigator = Get.nestedKey(10)?.currentState;
        if (nestedNavigator != null && nestedNavigator.canPop()) {
          nestedNavigator.pop();
          return false;
        }

        // Nếu không còn route nào => show confirm exit
        final bool shouldExit = await DialogUtils.showCustomExitConfirm();
        return shouldExit;
      },
      child: const BodyBuilder(),
    );
  }
}

///=============================== [COMPONENT_PAGE] ====================================

///---> [BUILD_BOTTOM_NAVIGATION_BAR]
class _BuildBottomNavigationBar extends StatelessWidget {
  const _BuildBottomNavigationBar();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (controller) => controller.currentPage.obx(
        onData: (index) => BottomNavigationBarWidget(
          currentIndex: index,
          selectedItemColor: AppThemeColors.iconActive,
          onChange: (int index) {
            controller.onChangeItemBottomBar(index);
          },
        ),
      ),
    );
  }
}

///=============================== [MAIN_BODY] ====================================

///---> [BODY_BUILD]
class BodyBuilder extends GetView<NavigationController> {
  const BodyBuilder({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(10),
      initialRoute: "/home-section",
      onGenerateRoute: (settings) => controller.onGenerateRoute(settings),
    );
  }
}
