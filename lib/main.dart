import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_quest/app.dart';
import 'package:food_quest/configs.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    final exception = details.exception;
    if (exception is HttpException && exception.message.contains('403')) {
      return;
    }
    FlutterError.presentError(details);
  };

  await configs();
  runApp(const App());
}
