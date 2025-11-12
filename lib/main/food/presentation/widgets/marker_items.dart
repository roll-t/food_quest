import 'package:flutter/material.dart';
import 'package:food_quest/core/config/const/app_padding.dart';
import 'package:food_quest/core/config/theme/app_colors.dart';

class MarkerItems extends StatelessWidget {
  final List<Widget> icons;
  final bool isInWheel;

  const MarkerItems({
    super.key,
    required this.icons,
    this.isInWheel = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Row(
              spacing: 6,
              children: [
                for (var icon in icons)
                  Container(
                    padding: AppEdgeInsets.all4,
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      shape: BoxShape.circle,
                    ),
                    child: icon,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
