import 'package:flutter/material.dart';

class KeyboardUtils {
  static void hiddenKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}