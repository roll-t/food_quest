import 'package:food_quest/core/config/const/app_images.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/const/app_text_styles.dart';
import 'package:food_quest/core/ui/widgets/images/asset_image_widget.dart';
import 'package:food_quest/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? textTitleColor;
  final String? icon;
  final String title;
  final double? height;
  final List<Widget>? menuItem;
  final bool hideBack;
  final PreferredSizeWidget? bottomAppBar;

  const MainAppBar({
    super.key,
    this.textTitleColor,
    this.icon,
    this.title = '',
    this.menuItem,
    this.height = 44.0,
    this.bottomAppBar,
    this.hideBack = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      elevation: 0.5,
      backgroundColor: Colors.transparent,
      toolbarHeight: preferredSize.height,
      iconTheme: IconThemeData(color: textTitleColor),
      bottom: bottomAppBar,
      title: _buildTitle(),
      actions: [
        (menuItem?.isNotEmpty ?? false)
            ? Container(
                color: AppColors.white.withOpacity(0.35),
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  right: 20,
                ),
                child: Row(children: menuItem!),
              )
            : Container(height: 50),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.35),
      ),
      child: Row(
        children: [
          const AssetImageWidget(
            width: 30,
            assetPath: AppImages.iLogo,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextWidget(
              text: title,
              textStyle: AppTextStyle.bold20,
              color: AppColors.white,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
