import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:food_quest/core/ui/widgets/app_bar/custom_appbar.dart';
import 'package:food_quest/core/utils/keyboard_utils.dart';
import 'package:flutter/material.dart';

class StandardLayoutWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? navigationBar;
  final Widget bodyBuilder;
  final EdgeInsets? padding;
  final String? titleAppBar;
  final bool isUnfocusInput;
  final Color? backgroundColor;
  const StandardLayoutWidget({
    super.key,
    this.appBar,
    this.padding,
    this.navigationBar,
    this.titleAppBar,
    this.backgroundColor,
    this.isUnfocusInput = false,
    required this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: KeyboardUtils.hiddenKeyboard,
      child: Container(
        color: AppThemeColors.background300,
        child: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: backgroundColor ?? Colors.transparent,
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: AppThemeColors.appBar,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                height: 220,
              ),
            ),
            Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              appBar: titleAppBar != null
                  ? CustomAppBar(
                      title: titleAppBar,
                    )
                  : appBar,
              body: Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                    ).copyWith(
                      top: 15,
                    ),
                child: bodyBuilder,
              ),
              bottomNavigationBar: navigationBar,
            ),
          ],
        ),
      ),
    );
  }
}
