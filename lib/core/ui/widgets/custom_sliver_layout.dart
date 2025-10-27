import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSliverLayout extends StatelessWidget {
  final Widget? appBar;
  final Widget? bodyBuilder;
  final SliverList? sliverList;
  final bool isLeadingAppBar;
  const CustomSliverLayout({
    super.key,
    this.appBar,
    this.isLeadingAppBar = true,
    this.bodyBuilder,
    this.sliverList,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: !isLeadingAppBar
              ? null
              : const Center(
                  child: IconCircle(),
                ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: SizedBox(),
          ),
          title: appBar,
          floating: true,
          snap: true,
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          surfaceTintColor: AppColors.transparent,
          flexibleSpace: Container(
            color: AppThemeColors.background300,
          ),
        ),
        if (sliverList != null) sliverList!,
        if (bodyBuilder != null)
          SliverToBoxAdapter(
            child: bodyBuilder,
          ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 50),
        )
      ],
    );
  }
}

class IconCircle extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  const IconCircle({
    super.key,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.back(),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.dark300.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(1000),
        ),
        child: child ??
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
            ),
      ),
    );
  }
}
