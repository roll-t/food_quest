import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AssetImageWidget extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? errorWidget;

  const AssetImageWidget({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      assetPath,
      width: width,
      height: height,
      filterQuality: FilterQuality.low,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          const Icon(
            Icons.broken_image,
            color: AppColors.palette1,
          ),
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}
