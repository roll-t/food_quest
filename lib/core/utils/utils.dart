import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static SvgPicture iconSvg({
    required String svgUrl,
    double size = 25,
    Color? color,
  }) {
    return SvgPicture.asset(
      svgUrl,
      width: size,
      height: size,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Future<void> lanchUrl(String url, {BuildContext? context}) async {
    final Uri uri = Uri.tryParse(url) ?? Uri();
    if (uri.toString().isEmpty) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("URL không hợp lệ")),
        );
      }
      return;
    }

    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        // fallback nếu không mở được
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Không thể mở URL")),
          );
        }
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi khi mở URL: $e")),
        );
      }
    }
  }

  static Future<T?> runWithLoading<T>(Future<T> Function() action) async {
    DialogUtils.showProgressDialog();
    try {
      return await action();
    } finally {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
  }

  static String getCurrentYear() {
    return DateTime.now().year.toString();
  }

  static bool isCurrentYear(String? year) {
    if (year == null) return false;
    return year == getCurrentYear();
  }
}
