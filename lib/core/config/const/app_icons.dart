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
  static const icClose = _PngIcon("${_root}ic_close$_ext");
  static const icAdd = _PngIcon("${_root}ic_add$_ext");
  static const icCloseV2 = _PngIcon("${_root}ic_close_v2$_ext");
}

class _PngIcon {
  final String path;
  const _PngIcon(this.path);

  Widget show({
    double size = 25,
    BoxFit fit = BoxFit.contain,
    Color? color,
    EdgeInsets? padding,
    VoidCallback? onTap,
    Alignment? align, // cho phép null
  }) {
    final content = GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Image.asset(
          path,
          width: size,
          height: size,
          fit: fit,
          color: color,
        ),
      ),
    );

    if (align != null) {
      return Align(alignment: align, child: content);
    } else {
      return content;
    }
  }

  String get raw => path;
}
