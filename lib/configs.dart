import 'package:food_quest/app_binding.dart';
import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/config/load_env.dart';
import 'package:food_quest/core/config/storage_configs.dart';
import 'package:food_quest/core/lang/language_configs.dart';
import 'package:flutter/material.dart';

Future<void> configs() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  AppLogger.init();
  AppBinding().dependencies(); 
  await storageConfigs();
  await languageConfigs();
}

