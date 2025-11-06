import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
      image = defaultAsset != null
          ? Image.asset(
              defaultAsset!,
              width: width,
              height: height,
              fit: fit,
            )
          : const SizedBox.shrink();
    } else {
      image = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder ?? const SizedBox.shrink(),
        errorWidget: (context, url, error) => errorWidget ?? const SizedBox.shrink(),
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
