import 'package:food_quest/app.dart';
import 'package:food_quest/configs.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  await configs();
  runApp(const App());
} 