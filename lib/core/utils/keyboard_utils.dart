import 'package:flutter/material.dart';

class KeyboardUtils {
  static hiddenKeyboard({bool? isDelay}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isDelay ?? false) {
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }
}
