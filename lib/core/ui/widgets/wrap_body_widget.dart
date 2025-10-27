import 'package:food_quest/core/config/theme/app_colors.dart';
import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';

class WrapBodyWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final Widget? header;
  final Color backgroundColor;
  final Color backgroundHeader;
  final bool isMaxHeight;
  const WrapBodyWidget({
    super.key,
    required this.child,
    this.header,
    this.isMaxHeight = false,
    this.backgroundColor = AppColors.white,
    this.backgroundHeader = AppColors.white,
    this.padding = const EdgeInsets.all(12),
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppThemeColors.background100,
      ),
      child: Column(
        mainAxisSize: isMaxHeight ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) ...[
            Container(
              decoration: BoxDecoration(
                  color: AppThemeColors.background100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              padding: padding,
              child: header,
            ),
            const Divider(
              height: 0.5,
              thickness: 0.5,
              color: AppColors.text200,
            ),
          ],
          Container(
            padding: padding,
            child: child,
          ),
        ],
      ),
    );
  }
}
