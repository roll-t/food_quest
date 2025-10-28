import 'package:flutter/material.dart';
import 'package:food_quest/app.dart';
import 'package:food_quest/configs.dart';

Future<void> main() async {
  await configs();
  runApp(const App());
}
