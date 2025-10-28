import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/config/const/app_vectors.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? titleWidget;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool titleCenter;
  final Widget? leadingIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.titleWidget,
    this.actions,
    this.leadingIcon,
    this.showBackButton = true,
    this.titleCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppThemeColors.appBar,
      leading: showBackButton && Navigator.of(context).canPop()
          ? leadingIcon ??
              IconButton(
                icon: AppVectors.icArrowBack.show(),
                onPressed: () {
                  Get.back();
                },
              )
          : null,
      title: titleWidget ??
          TextWidget(
            maxLines: 2,
            text: title ?? "",
            textStyle: AppTextStyle.medium20,
            color: AppColors.white,
          ),
      centerTitle: titleCenter,
      actions: actions,
      elevation: 0,
      foregroundColor: AppColors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
