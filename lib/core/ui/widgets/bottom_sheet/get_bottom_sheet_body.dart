import 'package:food_quest/core/config/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';

class GetBottomSheetBody extends StatelessWidget {
  final Widget bodyBuilder;
  const GetBottomSheetBody({
    super.key,
    required this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      height: MediaQuery.of(context).size.height * 0.93,
      decoration: BoxDecoration(
        color: AppThemeColors.background300,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: bodyBuilder,
    );
  }
}
