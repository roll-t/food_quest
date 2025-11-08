import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:food_quest/app.dart';
import 'package:food_quest/configs.dart';
import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/main/food/presentation/page/add_food_page.dart';
import 'package:get/get.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DeepLinkService.init();
  await configs();
  String? pendingLink;
  bool coldStart = false;

  DeepLinkService.onReceive = (value, {required bool fromColdStart}) {
    if (Get.context == null) {
      pendingLink = value;
      coldStart = fromColdStart;
    } else {
      Get.toNamed(
        const AddFoodPage().routeName,
        arguments: value,
      );
    }
  };

  runApp(const App());

  WidgetsBinding.instance.addPostFrameCallback(
    (_) {
      if (pendingLink != null && coldStart) {
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.toNamed(const AddFoodPage().routeName, arguments: pendingLink);
        });
      }

      FlutterNativeSplash.remove();
    },
  );
}
