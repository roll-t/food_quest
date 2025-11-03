import 'package:flutter/material.dart';
import 'package:food_quest/app_binding.dart';
import 'package:food_quest/app_lifecycle_observer.dart';
import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/config/load_env.dart';
import 'package:food_quest/core/config/storage_configs.dart';
import 'package:food_quest/core/lang/language_configs.dart';
import 'package:food_quest/core/services/firebase/firebase_service.dart';

Future<void> configs() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addObserver(AppLifecycleHandler());
  await FirebaseService.init();
  AppLogger.init();
  loadEnv();
  AppBinding().dependencies();
  await storageConfigs();
  await languageConfigs();
}
