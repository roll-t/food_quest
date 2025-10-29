import 'package:flutter/material.dart';

class AppIcons {
  static const String _root = "assets/icons/";
  static const String _ext = ".png";

  static const icNoData = _PngIcon("${_root}ic_no_data$_ext");
  static const icAddFood = _PngIcon("${_root}ic_add_food$_ext");
  static const icHandCat = _PngIcon("${_root}ic_hand_cat$_ext");
  static const icCenterWheel = _PngIcon("${_root}ic_center_wheel$_ext");
  static const icAskAi = _PngIcon("${_root}ic_ask_ai$_ext");
  static const icHistory = _PngIcon("${_root}ic_history$_ext");
}

class _PngIcon {
  final String path;
  const _PngIcon(this.path);

  Widget show({
    double size = 25,
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    return Image.asset(
      path,
      width: size,
      height: size,
      fit: fit,
      color: color,
    );
  }

  String get raw => path;
}
