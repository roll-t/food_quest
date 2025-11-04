import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';

class CacheImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? defaultAsset;

  const CacheImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.defaultAsset,
  });

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (imageUrl == null || imageUrl!.isEmpty) {
      // URL rỗng → dùng ảnh mặc định hoặc icon
      image = defaultAsset != null
          ? Image.asset(
              defaultAsset!,
              width: width,
              height: height,
              fit: fit,
            )
          : const Icon(
              Icons.broken_image,
              color: AppColors.text400,
            );
    } else {
      // URL hợp lệ
      image = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ??
            const Center(
              child: CircularProgressIndicator(),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            const Icon(
              Icons.broken_image,
              color: AppColors.text400,
            ),
      );
    }

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }
    return image;
  }
}
