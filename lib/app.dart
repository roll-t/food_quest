import 'package:flutter/material.dart';
import 'package:food_quest/app_binding.dart';
import 'package:food_quest/core/config/theme/app_color_scheme.dart';
import 'package:food_quest/core/config/theme/app_theme.dart';
import 'package:food_quest/core/config/theme/theme_controller.dart';
import 'package:food_quest/core/lang/translation_service.dart';
import 'package:food_quest/core/routing/app_pages.dart';
import 'package:food_quest/features/splash/presentation/page/splash_page.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        AppColorScheme colorScheme = themeController.appColorScheme.value;

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          ///---> [Localization service]
          translations: LocalizationService(),
          locale: LocalizationService.locale,
          fallbackLocale: LocalizationService.fallbackLocale,
          supportedLocales: LocalizationService.locales,
          localizationsDelegates: LocalizationService.delegates,

          ///---> [Page config]
          getPages: appPage,
          initialRoute: "/splash",
          initialBinding: AppBinding(),
          home: const SplashPage(),
          unknownRoute: notFoundPage,

          ///---> [Theme config]
          theme: AppTheme.light(colorScheme),
          darkTheme: AppTheme.dark(colorScheme),
          themeMode: themeController.themeMode.value,
        );
      },
    );
  }
}
