import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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

  static Future<bool> isValidImageUrl(String? url) async {
    if (url == null || url.trim().isEmpty) return false; // URL null / rỗng

    try {
      final uri = Uri.tryParse(url);
      if (uri == null || !uri.hasScheme) return false; // URL sai format

      final response = await http.head(uri).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) return false;

      final contentType = response.headers['content-type'] ?? '';
      return contentType.startsWith('image/');
    } catch (_) {
      return false;
    }
  }

  static Widget? getSocialIcon({String? urlSocial, double iconSize = 20}) {
    if (urlSocial == null || urlSocial.isEmpty) return null;

    final uri = Uri.tryParse(urlSocial);
    final host = uri?.host.toLowerCase() ?? '';

    if (host.contains('tiktok.com')) {
      return AppIcons.icLogoTiktok.show(size: iconSize);
    } else if (host.contains('youtube.com') || host.contains('youtu.be')) {
      return AppIcons.icLogoYoutube.show(size: iconSize);
    } else if (host.contains('facebook.com') || host.contains('fb.watch')) {
      return AppIcons.icLogoFacebook.show(size: iconSize);
    } else if (host.contains('instagram.com')) {
      return AppIcons.icLogoInstagram.show(size: iconSize);
    } else if (host.contains('x.com') || host.contains('twitter.com')) {
      return AppIcons.icLogoTwitter.show(size: iconSize);
    }

    return AppIcons.icLogoGoogle.show(size: iconSize);
  }
}
