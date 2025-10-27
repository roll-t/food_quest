import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingList extends StatelessWidget {
  final double heightItem;
  final int countItems;
  final EdgeInsets? padding;
  final double? runSpacing;
  const ShimmerLoadingList({
    super.key,
    this.heightItem = 80,
    this.padding,
    this.runSpacing,
    required this.countItems,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: padding,
        itemCount: countItems,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: runSpacing ?? 0),
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerBase,
            highlightColor: AppColors.shimmerHighlight,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: heightItem,
              width: Get.width,
            ),
          ),
        ),
      ),
    );
  }
}
